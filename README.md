# 02-proofstamp - Base Native Architecture

> **Built for the Base Superchain & Stacks Bitcoin L2**

This project is architected to be **Base-native**: prioritizing onchain identity, low-latency interactions, and indexer-friendly data structures.

## 🔵 Base Native Features
- **Smart Account Ready**: Compatible with ERC-4337 patterns.
- **Identity Integrated**: Designed to resolve Basenames and store social metadata.
- **Gas Optimized**: Uses custom errors and batched call patterns for L2 efficiency.
- **Indexer Friendly**: Emits rich, indexed events for Subgraph data availability.

## 🟠 Stacks Integration
- **Bitcoin Security**: Leverages Proof-of-Transfer (PoX) via Clarity contracts.
- **Post-Condition Security**: Strict asset movement checks.

---
# ProofStamp

Document verification registry with immutable timestamps on Base and Stacks.

## Features

- Register document hashes with timestamps
- Verify document authenticity
- Track submission history
- Immutable proof of existence

## Contract Functions

### Base (Solidity)
- `registerDocument(hash, metadata)` - Register document hash
- `verifyDocument(hash)` - Verify and get document info
- `getUserDocuments(address)` - Get user's documents

### Stacks (Clarity)
- `register-document` - Register hash with metadata
- `verify-document` - Verify document existence
- `get-user-document-count` - Get document count

## Quick Start

```bash
pnpm install
pnpm dev
```

## Deploy

```bash
pnpm deploy:base
pnpm deploy:stacks
```

## License

MIT
