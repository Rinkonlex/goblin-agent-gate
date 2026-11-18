# GOBLIN PROTOCOL — Agent Gate

**GOBLIN PROTOCOL** is an NFT and token ecosystem on BNB Chain. Its **Agent Gate**
contract uses **Binance Agent ID** as the on-chain identity and access layer for
token distribution: any wallet holding an Agent ID can claim **10,000 $GOBLIN**,
one claim per identity.

## How Agent ID is integrated

`GoblinAgentGate.claim()` verifies the caller against the official Agent ID
registry on BNB Chain before paying out:

- Agent ID registry (SPACE ID Agent ID, ERC-721, non-transferable):
  `0x60B9262456dE011F7d15a54CdD8c48bAaa8B022F`
- Check: `balanceOf(caller) > 0` — the same check documented by Binance.
- One claim per Agent ID holder address (`claimed` mapping), paid from the
  gate's own $GOBLIN balance, funded by the GOBLIN PROTOCOL treasury.

Because an Agent ID is non-transferable and limited to one per user, the gate
replaces easily-gamed whitelists with sybil-resistant, verifiable agent
identity — Agent ID becomes the access key to the protocol's distribution.

## Contracts (BNB Chain)

| Contract | Address |
| --- | --- |
| GoblinAgentGate | `0x0d7b853cf7fd835df107ad6df3ea830e7c5cd6f6` |
| $GOBLIN token (V2) | `0x662dfbfb988f58e4040d05c1bbbc9fe44bff5ad4` |
| GBLN NFT (V2) | `0x35dc39df440791c064580f0d63643a770a798ab0` |

- Gate on BscScan: https://bscscan.com/address/0x0d7b853cf7fd835df107ad6df3ea830e7c5cd6f6
- Source verification (Sourcify, exact match, creation + runtime):
  https://sourcify.dev/#/lookup/0x0d7b853cf7fd835df107ad6df3ea830e7c5cd6f6
- First successful claim (proof of live Agent ID interaction):
  https://bscscan.com/tx/0x02c2399af291649a7747c9f5f862b187ef7f57291e60714f209cffde3987814b

## How to claim

1. Claim a free Agent ID in the Binance App (Wallet → homepage banner → Agent ID).
2. Call `claim()` on the GoblinAgentGate contract from your Agent ID wallet
   (e.g. via BscScan's Write Contract tab).
3. 10,000 $GOBLIN is transferred to your wallet. One claim per Agent ID.

## Tech

- Solidity `0.8.26`, optimizer 200 runs, no external dependencies.
- `GoblinAgentGate.sol` — the gate contract source (verified on-chain).
- `GoblinAgentGate.abi.json` — the gate contract ABI.

## License

MIT — see `LICENSE`.
