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
