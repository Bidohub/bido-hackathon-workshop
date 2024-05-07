# hackathon-workshop

This repository hosts two major projects focused on blockchain interoperability and decentralized financial applications: Bitcoin Bridge and L2 P2P Marketplace. Each project is detailed in its own subdirectory with documentation available in both English and Chinese.

## Projects
1. Bitcoin Bridge
The Bitcoin Bridge facilitates a decentralized cross-chain interaction between Bitcoin and Bevm. It leverages advanced blockchain scripting with MAST and smart contracts to ensure secure and seamless transactions.

- **English Documentation**: [View English README](./bitcoin-bridge/README.md)
- **Chinese Documentation**: [查看中文文档](./bitcoin-bridge/README-cn.md)
- **Key Components**:
  - `crosschainBridge.sol`: Smart contract for handling cross-chain operations.
  - `mast.script`: Script for MAST-based operations on the Bitcoin network.
  - `relay`: Infrastructure component for relaying transactions and proofs between blockchains.

## 2. L2 P2P Marketplace
The L2 P2P Marketplace operates on a Layer 2 scaling solution, enabling peer-to-peer trading of digital assets with enhanced transaction speed and reduced costs. It provides an efficient marketplace mechanism directly on the second layer without the need for users to interact with the main blockchain.

- **English Documentation**: [View English README](./l2-p2p-marketplace/README.md)
- **Chinese Documentation**: [查看中文文档](./l2-p2p-marketplace/README-cn.md)
- **Key Component**:
  - `l2MarketPlace.sol`: Smart contract for managing peer-to-peer transactions and order book functionality on Layer 2.

## Language Options
For convenience, documentation for each project is available in both English and Chinese. Use the links provided above to switch between languages according to your preference.

## Technical Details
The repository's structure is designed to facilitate easy navigation and understanding of the different components involved in each project. The modular design ensures that each part of the projects can be independently developed, tested, and deployed.

## Contributing
Contributions to either of the projects are welcome. Please refer to the specific project's documentation for guidelines on contributing and the process for submitting pull requests.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.