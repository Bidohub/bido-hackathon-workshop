# Decentralized P2P Marketplace on Bevm

This document provides a detailed description of the decentralized market operations for trading Runes and BRC20 tokens tokens on the Bevm platform. Users can directly purchase BTC assets located on the first layer (L1, i.e., the Bitcoin network) on the second layer (L2), and the entire purchasing process is seamless for users, without the need for users to be aware of the blockchain layer being operated on.

## Contract Overview

The `l2MarketPlace` smart contract on Bevm facilitates the creation and management of buy orders for Runes and BRC20 tokens. This contract integrates various functionalities such as order placement, cancellation, and execution while ensuring the integrity and security of the transactions.

## Features
* **Transparent Layer Interaction**: User operations on L2 directly affect the BTC asset status on L1, all handled automatically by the smart contract without any need for direct interaction with the Bitcoin network.
* **Order Placement and Execution**: Users can place buy orders through a simple interface on Bevm, with the system automatically handling all transactions and transfers related to BTC assets.
* **Decentralized Control and Security Measures**: Control mechanisms implemented through the smart contract ensure the security and transparency of transactions, preventing unauthorized actions.


## Smart Contract Functions

### `buyWithCrossChain(bytes _btcAddr, bytes _assetName, uint256 _assetAmount, uint8 _assetDivisibility)`
* Allows users to initiate buy orders for BTC on Bevm without directly accessing the Bitcoin network.
* This function also automatically calculates transaction fees and records the order details on the blockchain.

### `cancel(uint256 _orderId)`
* Provides users a straightforward method to cancel unexecuted orders, with the system automatically handling the refund of invested funds.

### `sellWithCrossChain(uint256[] _orderIds, bytes[] _txids)`
* Allows sellers to complete orders, with the system automatically managing the transfer of funds from L2 to L1, ensuring accurate execution of transactions.

## Security and Operational Controls
* **Seamless Cross-Layer Operations**: Cross-layer transactions are automatically managed by the smart contract, sparing users the need to worry about underlying technical details.
* **Emergency Control Mechanisms**: The contract provides functionalities to pause and resume operations, ensuring that activities can be immediately stopped when necessary.

## Example Usage

**Placing an Order**
```solidity
contractInstance.buyWithCrossChain("btc_address", "Runes", 100, 1, {value: web3.toWei(0.1, "ether")});
```
**Executing an Order**

```
contractInstance.sellWithCrossChain([orderId], ["txid"]);
```
