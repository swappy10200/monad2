// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract ReviewManager {
    struct Review {
        string content;
        uint8 rating;
        address reviewer;
        uint256 timestamp;
    }

    mapping(uint256 => Review) public reviews;
    uint256 public reviewCount;

    event ReviewSubmitted(uint256 id, string content, uint8 rating, address reviewer);

    function submitReview(string memory content, uint8 rating) public {
        require(rating >= 1 && rating <= 5, "Rating must be between 1 and 5");
        reviews[reviewCount] = Review(content, rating, msg.sender, block.timestamp);
        emit ReviewSubmitted(reviewCount, content, rating, msg.sender);
        reviewCount++;
    }
}