// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract DocumentManager {
    struct Document {
        string title;
        string content;
        address author;
        uint256 timestamp;
    }

    mapping(uint256 => Document) public documents;
    uint256 public documentCount;

    event DocumentCreated(uint256 id, string title, address author);

    function createDocument(string memory title, string memory content) public {
        documents[documentCount] = Document(title, content, msg.sender, block.timestamp);
        emit DocumentCreated(documentCount, title, msg.sender);
        documentCount++;
    }
}