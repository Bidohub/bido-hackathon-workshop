# Bido-Hackathon-Workshop

This repository hosts two major projects focused on blockchain interoperability and decentralized financial applications: Bitcoin Bridge and L2 P2P Marketplace. Each project is detailed in its own subdirectory with documentation available in both English and Chinese.

## 1. Bitcoin Bridge
The Bitcoin Bridge facilitates a decentralized cross-chain interaction between Bitcoin and Bevm. It leverages advanced blockchain scripting with MAST and smart contracts to ensure secure and seamless transactions.

- **English Documentation**: [View English README](./bitcoin-bridge/README.md)
- **Chinese Documentation**: [查看中文文档](./bitcoin-bridge/README-cn.md)
- **Key Components**:
  - `crosschainBridge.sol`: Smart contract for handling cross-chain operations.
  - `mast.script`: Script for MAST-based operations on the Bitcoin network.
  - `relay`: Infrastructure component for relaying transactions and proofs between blockchains.

## 2. Decentralized P2P L2 Marketplace on Bevm
The Decentralized P2P L2 Marketplace operates on a Layer 2 scaling solution, enabling peer-to-peer trading of digital assets with enhanced transaction speed and reduced costs. It provides an efficient marketplace mechanism directly on the second layer without the need for users to interact with the main blockchain.

- **English Documentation**: [View English README](./l2-p2p-marketplace/README.md)
- **Chinese Documentation**: [查看中文文档](./l2-p2p-marketplace/README-cn.md)
- **Key Component**:
  - `l2P2PMarketPlace.sol`: Smart contract for managing peer-to-peer transactions and order book functionality on Layer 2.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.