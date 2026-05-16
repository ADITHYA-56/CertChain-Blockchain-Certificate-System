// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * ============================================================
 *   CertChain — On-Chain Academic Certificate Registry
 *   Solidity ^0.8.20 | Deploy on Sepolia Testnet
 * ============================================================
 *
 * HOW TO DEPLOY (one-time setup):
 *   1. Go to https://remix.ethereum.org
 *   2. Create a new file: CertChain.sol
 *   3. Paste this entire file
 *   4. Compile tab → select "0.8.20" → click "Compile CertChain.sol"
 *   5. Deploy & Run tab:
 *        • Environment: "Injected Provider - MetaMask"
 *        • Make sure MetaMask is on "Sepolia" network
 *        • Click "Deploy"
 *        • Approve the transaction in MetaMask
 *   6. Copy the deployed contract address from the left panel
 *   7. Paste it in blockchain-real.js → CONTRACT_ADDRESS variable
 *
 * Free Sepolia ETH (for gas): https://sepoliafaucet.com
 * ============================================================
 */

contract CertChain {

    // ── Certificate record stored on-chain ──────────────────
    struct Certificate {
        string  certificateId;      // e.g. "CERT-ABC123-XYZ"
        bytes32 certHash;           // SHA-256 of certificate JSON
        address issuer;             // wallet address that issued it
        uint256 timestamp;          // block.timestamp of issuance
        string  metadata;           // JSON string of cert fields
        bool    exists;             // existence flag
    }

    // ── Storage ─────────────────────────────────────────────
    mapping(string => Certificate) private certificates;
    string[] private certificateIds;
    address public owner;

    // ── Events ──────────────────────────────────────────────
    event CertificateIssued(
        string  indexed certificateId,
        bytes32         certHash,
        address indexed issuer,
        uint256         timestamp,
        string          metadata
    );

    // ── Constructor ─────────────────────────────────────────
    constructor() {
        owner = msg.sender;
    }

    // ── Issue a new certificate ──────────────────────────────
    // certHash: pass as bytes32 (the SHA-256 of the cert JSON)
    // metadata: JSON string of all certificate fields
    function issueCertificate(
        string  calldata certificateId,
        bytes32          certHash,
        string  calldata metadata
    ) external {
        require(bytes(certificateId).length > 0, "Certificate ID required");
        require(!certificates[certificateId].exists, "Certificate ID already exists");

        certificates[certificateId] = Certificate({
            certificateId : certificateId,
            certHash      : certHash,
            issuer        : msg.sender,
            timestamp     : block.timestamp,
            metadata      : metadata,
            exists        : true
        });

        certificateIds.push(certificateId);

        emit CertificateIssued(certificateId, certHash, msg.sender, block.timestamp, metadata);
    }

    // ── Get a single certificate ─────────────────────────────
    function getCertificate(string calldata certificateId)
        external
        view
        returns (
            string  memory id,
            bytes32        certHash,
            address        issuer,
            uint256        timestamp,
            string  memory metadata,
            bool           exists
        )
    {
        Certificate storage c = certificates[certificateId];
        return (c.certificateId, c.certHash, c.issuer, c.timestamp, c.metadata, c.exists);
    }

    // ── Get all certificate IDs ──────────────────────────────
    function getAllCertificateIds() external view returns (string[] memory) {
        return certificateIds;
    }

    // ── Total count of certificates ──────────────────────────
    function getCertificateCount() external view returns (uint256) {
        return certificateIds.length;
    }

    // ── Verify a certificate hash matches what's on-chain ────
    function verifyCertificateHash(string calldata certificateId, bytes32 hashToCheck)
        external
        view
        returns (bool)
    {
        Certificate storage c = certificates[certificateId];
        return c.exists && c.certHash == hashToCheck;
    }
}
