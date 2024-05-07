# Decentralized Cross-Chain Bridge from Bitcoin to Bevm Using MAST

The implementation of the decentralized cross-chain bridge leveraging MAST (Merkleized Abstract Syntax Trees) technology facilitates a secure and efficient process while enhancing privacy by revealing only essential transaction information. This document outlines the comprehensive steps involved in the bridge's operation.

## 1. Bitcoin Chain: Asset Locking
The first step involves users sending their BTC to a specific address controlled by a MAST script on the Bitcoin blockchain. This script is a complex conditional script designed to manage the release of funds under certain conditions.

* Script Creation: The script incorporates multiple branches, allowing the release of funds under conditions such as successful event proofs on Bevm or reaching a specific time point (enabling refunds through a timeout mechanism).
* Sending Bitcoin: Users execute a standard Bitcoin transaction to send BTC to the MAST-controlled address.

## 2. Interaction on Bevm
Upon successful locking of the Bitcoin, off-chain participants (such as cross-chain service providers) monitor these transactions and trigger corresponding actions on the Bevm blockchain.

* Off-Chain Monitoring and Verification: Utilizing relay service nodes to monitor the Bitcoin network, the service waits to confirm the transaction has been locked, then collects necessary transaction data (e.g., transaction ID, Merkle Proof), potentially using cross-chain messaging protocols like Polyhedra.
* Submitting Proof to Bevm: This data is submitted to a smart contract on Bevm. This contract is responsible for verifying the evidence received from the Bitcoin network to confirm that the locking event has indeed occurred.

## 3. Token Minting
On Bevm, a smart contract mints an equivalent amount of tokens based on the amount of Bitcoin locked.

* Minting Process: The smart contract mints a new token (e.g., bBTC), representing the Bitcoin locked on Bevm.
* Distributing bBTC: The minted bBTC is allocated to the Bevm address of the user who initiated the cross-chain request.

## 4. Redemption and Unlocking
After using bBTC on Bevm, users may wish to convert them back to the original Bitcoin. This requires initiating a redemption operation on Bevm, followed by unlocking the Bitcoin through the MAST script.

* Redemption Request: Users submit a redemption request from Bevm to Bitcoin, burning the corresponding amount of bBTC.
* Submit Unlock Request: Off-chain services monitor these redemption events and submit the redemption proof to the MAST script on the Bitcoin network.
* Unlocking Bitcoin: Once the MAST script verifies the redemption proof as valid, the corresponding Bitcoin is unlocked and sent to the user's specified Bitcoin address.

## Preventing Replay Attacks
In cross-chain operations, preventing replay attacks involves ensuring that each operation is based on a unique event or condition.

1. Unique Transaction Identifiers (Nonce):
Each transfer from Bitcoin to Bevm should include a unique identifier (such as a nonce) stored within the Bitcoin's MAST structure.
The Bevm smart contract checks this nonce when verifying the Bitcoin locking transaction to ensure that each transaction is processed only once.
2. Timestamps and Block Confirmations:
Including the timestamp of the transaction and/or the block height from the Bitcoin network allows the Bevm contract to verify that the transaction is neither outdated nor revoked.
3. Off-Chain Coordination Services:
Utilize off-chain trusted services to track and verify all cross-chain requests between Bitcoin and Bevm, ensuring the uniqueness and validity of each request.

## Preventing Double Spending

In the cross-chain bridge from Bitcoin to Bevm, preventing double spending focuses on ensuring that once Bitcoin is locked, the corresponding Bevm token (e.g., bBTC) is only minted once and remains in a 1:1 lockup with the original Bitcoin.

1. Cross-Chain Verification:
* The bridge needs to integrate blockchain data verification from both Bitcoin and Bevm. For instance, the Bevm smart contract might require a Merkle proof of the Bitcoin transaction to verify that the funds have indeed been locked.
2. Bi-directional Confirmations:
* Before minting wBTC, confirmations are required from both chains: the Bitcoin chain must have at least 3 confirmations indicating the funds have been locked, and the Bevm chain must confirm that no corresponding wBTC has been previously minted.