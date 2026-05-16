# 🔗 CertChain — Blockchain-Based Secure Academic Certificate Verification System

> **Final University Project** | Pure HTML · CSS · JavaScript | No frameworks | No backend

---

## 🧠 What Is CertChain?

CertChain is a **browser-based blockchain** that issues and cryptographically verifies academic certificates. It implements all core blockchain concepts from scratch in pure JavaScript:

- **SHA-256 Hashing** via the Web Crypto API (real NIST standard)
- **Proof-of-Work Mining** with adjustable difficulty
- **Hash-Linked Blockchain** (each block stores the previous block's hash)
- **Tamper Detection** — any modification breaks the chain, detected with exact diagnostics
- **4-Stage Verification Pipeline** — VALID or INVALID with precise failure reason
- **localStorage Persistence** — chain survives across browser sessions

---

## 📁 Project Structure

```
BLOCKCHAIN CERTCHAIN/
├── blockchain.js      — Core blockchain engine (Block + Blockchain classes)
├── index.html         — Home page with blockchain stats & live chain banner
├── issue.html         — Issue certificates with live mining progress
├── dashboard.html     — Full blockchain explorer
├── verify.html        — 4-step cryptographic verification
├── security.html      — Security education + live SHA-256 demo + tamper simulation
├── docs.html          — Complete academic documentation (13 sections)
├── styles.css         — Premium dark blockchain theme
└── README.md          — This file
```

---

## 🚀 How to Run

1. Open `index.html` in any modern browser (Chrome, Firefox, Edge)
2. No server, no build step, no dependencies required

---

## ⛓️ Blockchain Concepts Demonstrated

| Concept | Implementation |
|---------|----------------|
| SHA-256 Hashing | `crypto.subtle.digest('SHA-256', ...)` — real cryptographic hash |
| Genesis Block | Block #0 with `previousHash = "0000…0"`, mined at init |
| Proof-of-Work | Nonce iteration until `hash.startsWith("0".repeat(difficulty))` |
| Block Structure | index, timestamp, data, previousHash, nonce, hash |
| Hash Linking | `block.previousHash = prevBlock.hash` |
| Tamper Detection | Recompute hash and compare — mismatch = tampered |
| Chain Validation | Traverse all blocks, check hash + linkage + PoW |
| Certificate Hashing | `certHash = SHA256(JSON.stringify(certData))` |
| Persistence | Full chain serialized to localStorage as JSON |

---

## 🔐 Verification Pipeline

When verifying a Certificate ID, four stages are checked in order:

1. **Certificate Existence** — ID found in blockchain?
2. **Certificate Hash Integrity** — SHA-256 of data matches stored `certHash`?
3. **Block Hash Validity** — Block's stored hash matches recomputed hash?
4. **Full Chain Integrity** — Every block passes hash + linkage + PoW check?

All 4 pass → **✅ CERTIFICATE VALID** | Any fail → **❌ INVALID + exact reason**

---

## 🛡️ Security Properties

- **Immutability**: Modifying any certificate changes its hash, breaking every subsequent block
- **Computational Security**: Proof-of-Work makes chain rewriting computationally expensive
- **No Trust Required**: Verification is purely mathematical — no institution contact needed
- **Avalanche Effect**: 1-character change produces completely different SHA-256 hash

---

## � Academic Documentation

Complete formal documentation is available at [`docs.html`](docs.html) covering:

Abstract · Problem Statement · Objectives · Blockchain Architecture · Block & Chain Structure · Proof-of-Work Algorithm · Certificate Issuance Flow · Verification Flow · Security Analysis · Advantages · Limitations · Future Enhancements · Conclusion

---

## 🔬 Technology Used

- **Language**: Pure JavaScript (ES2020+)
- **Hashing**: Web Crypto API (`crypto.subtle.digest`)
- **Storage**: Browser localStorage
- **UI**: HTML5 + CSS3 (no frameworks)
- **Fonts**: Google Fonts (Inter, JetBrains Mono)

---

*CertChain — Demonstrating that cryptographic hashing + Proof-of-Work = unforgeable academic records.*