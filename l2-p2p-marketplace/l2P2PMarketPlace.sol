// Copyright (c) OmniBTC, Inc.
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/security/Pausable.sol";

contract l2P2PMarketPlace is Ownable, Pausable {
    struct OrderInfo {
        uint256 orderId;
        address creator;
        bytes btcAddr;
        bytes assetName;
        uint256 assetAmount;
        uint8 assetDivisibility;
        uint256 btcAmount;
        uint256 btcFee;
        uint8 status;
        bytes txid;
    }

    uint256 public constant RAY = 1e18;

    uint256 public feeRate;

    uint256 public nextOrderId;

    mapping(uint256 => OrderInfo) public orderInfos;

    mapping(address => uint256) public sellers;

    event Buy(OrderInfo order);

    event Sell(OrderInfo order);

    event Update(OrderInfo order);

    event Cancel(OrderInfo order);

    event Seller(address indexed seller, uint256 flag);

    event ReFund(uint256 amount);

    /**
     * @dev Throws if called by any account other than the seller.
     */
    modifier onlySeller() {
        require(sellers[msg.sender] == 1, "Ownable: caller is not the seller");
        _;
    }

    constructor() {
        feeRate = 1e15;
    }

    function reFund(uint256 _amount) external onlyOwner {
        _sendValue(owner(), _amount);
        emit ReFund(_amount);
    }

    /**
     * @notice Set seller
     */
    function setSeller(address _seller, uint256 _flag) external onlyOwner {
        sellers[_seller] = _flag;
    }

    /**
     * @notice Set order fee
     */
    function setFee(uint256 _feeRate) external onlyOwner {
        feeRate = _feeRate;
    }

    /**
     * @notice Stop order operations
     */
    function stop() external onlyOwner {
        _pause();
    }

    /**
     * @notice Resume order operations
     */
    function resume() external onlyOwner {
        _unpause();
    }

    // solhint-disable-next-line no-complex-fallback
    fallback() external payable {
        // protection against accidental submissions by calling non-existent function
        revert("NOT_SUPPORT_FALLBACK");
    }

    /**
     * @notice Send funds to the pool
     */
    // solhint-disable-next-line no-complex-fallback
    receive() external payable {
        // protection against accidental submissions by calling non-existent function
        revert("NOT_SUPPORT_RECEIVE");
    }

    // 初始化跨链交易
    function initiateCrossChainTransaction(
        bytes memory _btcAddr,
        uint256 _btcAmount
    ) private {
        // 调用跨链桥的合约进行资金锁定
        // 这里需要根据实际的跨链桥合约接口进行调整
    }

    // 处理跨链资金接收
    function handleReceivedFunds(uint256 _orderId, bytes32 _txid) private {
        // 验证交易并更新订单状态
        OrderInfo storage order = orderInfos[_orderId];
        order.txid = _txid;
        order.status = 1; // 标记为完成
        emit Unlocked(order.creator, order.btcAmount);
    }

    function buyWithCrossChain(
        bytes calldata _btcAddr,
        bytes calldata _assetName,
        uint256 _assetAmount,
        uint8 _assetDivisibility
    ) external payable whenNotPaused {
        require(msg.value > 0, "VALUE IS ZERO");
        uint256 newOrderId = nextOrderId;
        OrderInfo storage newOrder = orderInfos[newOrderId];
        newOrder = OrderInfo({
            orderId: newOrderId,
            creator: msg.sender,
            btcAddr: _btcAddr,
            assetName: _assetName,
            assetAmount: _assetAmount,
            assetDivisibility: _assetDivisibility,
            btcAmount: msg.value,
            btcFee: (msg.value * feeRate) / RAY,
            status: 0,
            txid: bytes("")
        });
        nextOrderId++;
        initiateCrossChainTransaction(_btcAddr, msg.value); // 初始化跨链交易
        emit Buy(newOrder);
    }

    function cancel(uint256 _orderId) external whenNotPaused {
        require(_orderId < nextOrderId, "NOT ORDER");
        OrderInfo memory orderInfo = orderInfos[_orderId];
        require(orderInfo.creator == msg.sender, "NOT CREATOR");
        require(orderInfo.status == 0, "ORDER FINISHED");
        orderInfos[_orderId].status = 2;
        _sendValue(orderInfo.creator, orderInfo.btcAmount);
        emit Cancel(orderInfos[_orderId]);
    }

    function sellWithCrossChain(
        uint256[] calldata _orderIds,
        bytes[] memory _txids
    ) external onlySeller whenNotPaused {
        require(_orderIds.length == _txids.length, "INVALID LENGTH");
        uint256 allBtcAmount;
        for (uint256 i; i < _orderIds.length; i++) {
            require(
                _orderIds[i] < nextOrderId &&
                    orderInfos[_orderIds[i]].status == 0,
                "INVALID ORDER"
            );
            OrderInfo storage orderInfo = orderInfos[_orderIds[i]];
            handleReceivedFunds(_orderIds[i], _txids[i]); // 处理接收到的资金
            allBtcAmount += orderInfo.btcAmount;
            emit Sell(orderInfo);
        }
        _sendValue(owner(), allBtcAmount);
    }

    function update(
        uint256[] calldata _orderIds,
        bytes[] memory _txids
    ) external onlySeller whenNotPaused {
        require(_orderIds.length == _txids.length, "INVALID LENGTH");
        uint256 latestOrderId = nextOrderId;
        for (uint256 i; i < _orderIds.length; i++) {
            require(_orderIds[i] < latestOrderId, "NOT ORDER");
            OrderInfo memory orderInfo = orderInfos[_orderIds[i]];
            require(orderInfo.status == 1, "ORDER NOT SELL");
            orderInfos[_orderIds[i]].txid = _txids[i];
            emit Update(orderInfos[_orderIds[i]]);
        }
    }

    function cancelByOwner(
        uint256[] calldata _orderIds
    ) external onlyOwner whenNotPaused {
        uint256 latestOrderId = nextOrderId;
        for (uint256 i; i < _orderIds.length; i++) {
            require(_orderIds[i] < latestOrderId, "NOT ORDER");
            OrderInfo memory orderInfo = orderInfos[_orderIds[i]];
            require(orderInfo.status == 0, "ORDER FINISHED");
            orderInfos[_orderIds[i]].status = 2;
            _sendValue(orderInfo.creator, orderInfo.btcAmount);
            emit Cancel(orderInfos[_orderIds[i]]);
        }
    }

    function _sendValue(address _recipient, uint256 _amount) internal {
        if (address(this).balance < _amount) revert("NOT_ENOUGH_BTC");

        // solhint-disable-next-line
        (bool success, ) = _recipient.call{value: _amount}("");
        if (!success) revert("CANT_SEND_VALUE");
    }
}
