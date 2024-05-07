# Bevm 上的点对点去中心 MarketPlace

本文档详细介绍了在 Bevm 平台上交易 Runes以及Brc20 代币的去中心化市场操作。用户可以在第二层（L2）上直接购买位于第一层（L1，即比特币网络）的 BTC 资产，而整个购买过程对用户来说是无缝的，无需用户感知正在操作的区块链层级。

## 合约概览

`l2MarketPlace` 智能合约在 Bevm 上促进了创建和管理购买 Runes以及Brc20 代币的订单。该合约整合了订单放置、取消、执行等多种功能，确保了交易的完整性和安全性，同时为用户提供了一种几乎无需了解底层区块链细节的交易方式。

## 功能特性
* **透明的层级交互**：用户在 L2 上的操作可以直接影响 L1 上的 BTC 资产状态，所有这些操作均通过智能合约自动处理，用户无需直接与比特币网络交互。
* **订单放置与执行**：用户通过简单的界面在 Bevm 上放置购买订单，系统自动处理与 BTC 资产相关的所有交易和转账。
* **去中心化控制与安全措施**：通过智能合约实现的控制机制确保交易的安全性和透明度，防止未授权行为。

## 集成跨链桥功能

### 使用跨链桥进行的操作
利用去中心化跨链桥，`l2MarketPlace` 可以执行以下关键功能：

#### `initiateCrossChainBuy`
- 用户在 Bevm 发起购买 BTC 的订单时，合约会通过跨链桥在比特币网络上锁定相应的 BTC。
- 这一功能确保用户可以直接从 Bevm 控制 BTC 资产，增加了操作的便利性和速度。

#### `finalizeCrossChainSell`
- 当订单在 Bevm 被执行时，合约通过跨链桥触发比特币网络释放相应的 BTC 到卖家指定的地址。
- 这一流程自动化了从 L2 到 L1 的 BTC 转移，确保了资金的安全和交易的透明度。


## 智能合约函数

### `buyWithCrossChain(bytes _btcAddr, bytes _assetName, uint256 _assetAmount, uint8 _assetDivisibility)`
* 允许用户在不直接接触比特币网络的情况下，在 Bevm 上发起购买 BTC 的订单。
* 此函数还自动计算交易费用，并将订单详细信息记录在链上。

### `cancel(uint256 _orderId)`
* 为用户提供了一种简单的方式来取消未完成的订单，系统自动处理资金的返还。

### `sellWithCrossChain(uint256[] _orderIds, bytes[] _txids)`
* 允许卖家完成订单，系统自动处理从 L2 到 L1 的资金转移，确保交易的准确执行。

## 安全和操作控制
* **无缝的跨层操作**：通过智能合约自动管理跨层交易，用户无需担心底层技术细节。
* **紧急操作控制**：合约提供了暂停和恢复操作的功能，确保在需要时可以立即停止所有活动。


## 示例用法

**下单**
```
contractInstance.buyWithCrossChain("btc_address", "Runes", 100, 1, {value: web3.toWei(0.1, "ether")});
```

**执行订单**

```
contractInstance.sellWithCrossChain([orderId], ["txid"]);

```
