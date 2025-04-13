// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract NewsManager {
    struct NewsArticle {
        string title;
        string content;
        address author;
        uint256 timestamp;
    }

    mapping(uint256 => NewsArticle) public newsArticles;
    uint256 public articleCount;

    event ArticlePublished(uint256 id, string title, address author);

    function publishArticle(string memory title, string memory content) public {
        newsArticles[articleCount] = NewsArticle(title, content, msg.sender, block.timestamp);
        emit ArticlePublished(articleCount, title, msg.sender);
        articleCount++;
    }
}