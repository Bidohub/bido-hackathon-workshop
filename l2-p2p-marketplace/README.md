## Decentralized P2P Runes Marketplace on Bevm
This document provides a detailed description of the decentralized market operations for trading Runes tokens on the Bevm platform, where users can directly purchase BTC assets located on the first layer (L1, i.e., the Bitcoin network) on the second layer (L2), and the entire purchasing process is seamless for users, without the need for users to be aware of the blockchain layer being operated on.

## Contract Overview
The BuyOrder smart contract on Bevm facilitates the creation and management of buy orders for Runes tokens. This contract integrates various functionalities such as order placement, cancellation, and execution while ensuring the integrity and security of the transactions.

Features
* Order Placement: Users can place orders specifying the amount of Runes tokens they wish to buy and the price they are willing to pay in BTC.
* Order Execution: Owners (or designated sellers) can execute these orders by transferring the specified amount of Runes tokens and receiving BTC in return.
* Decentralized Control: The contract is governed through owner privileges for critical administrative functions and seller-specific actions controlled via seller flags.
* Security Measures: Includes checks for order validity, execution rights, and appropriate transaction states to prevent unauthorized actions and ensure transaction correctness.

## Smart Contract Functions

`buy(bytes _btcAddr, bytes _assetName, uint256 _assetAmount, uint8 _assetDivisibility)`
* Allows users to place a buy order by specifying their Bitcoin address, the asset name (Runes), and the amount and divisibility of the asset.
* The function calculates the transaction fee based on the current fee rate and logs the order details.

`cancel(uint256 _orderId)`
* Enables users to cancel their orders if they have not been executed or fulfilled, returning the invested BTC amount.

`sell(uint256[] _orderIds, bytes[] _txids)`
* Allows the seller to execute multiple orders. Sellers must provide the transaction IDs for the BTC transactions as proof of token transfer.
* The function aggregates the total BTC amount from all fulfilled orders and transfers it to the owner’s address.

`update(uint256[] _orderIds, bytes[] _txids)`
* Used by sellers to update the blockchain transaction IDs associated with executed orders, ensuring transparency and traceability of the executed trades.

## Security and Operational Controls
* Pausable Operations: The contract can be paused or resumed by the owner, providing a way to stop operations in case of emergency or maintenance.
* ReFund Mechanism: Allows the contract owner to refund BTC, providing an additional layer of control over the contract’s financial operations.

## Example Usage

**Placing an Order**

```
contractInstance.buy("btc_address", "Runes", 100, 1, {value: web3.toWei(0.1, "ether")});

```
** Executing an Order

```
contractInstance.sell([orderId], ["txid"]);

```
