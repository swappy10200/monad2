// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract CertificateManager {
    struct Certificate {
        string title;
        string description;
        address issuer;
        uint256 issueDate;
        bool revoked;
    }

    mapping(uint256 => Certificate) public certificates;
    uint256 public certificateCount;

    event CertificateIssued(uint256 id, string title, string description, address issuer, uint256 issueDate);
    event CertificateRevoked(uint256 id);

    function issueCertificate(string memory title, string memory description) public {
        certificates[certificateCount] = Certificate(title, description, msg.sender, block.timestamp, false);
        emit CertificateIssued(certificateCount, title, description, msg.sender, block.timestamp);
        certificateCount++;
    }

    function revokeCertificate(uint256 id) public {
        require(certificates[id].issuer == msg.sender, "Only the issuer can revoke the certificate");
        certificates[id].revoked = true;
        emit CertificateRevoked(id);
    }
}