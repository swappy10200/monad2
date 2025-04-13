// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract ApplicationManager {
    struct Application {
        string name;
        string details;
        address applicant;
        uint256 applicationDate;
        bool approved;
        bool rejected;
    }

    mapping(uint256 => Application) public applications;
    uint256 public applicationCount;

    event ApplicationSubmitted(uint256 id, string name, string details, address applicant);
    event ApplicationApproved(uint256 id);
    event ApplicationRejected(uint256 id);

    function submitApplication(string memory name, string memory details) public {
        applications[applicationCount] = Application(name, details, msg.sender, block.timestamp, false, false);
        emit ApplicationSubmitted(applicationCount, name, details, msg.sender);
        applicationCount++;
    }

    function approveApplication(uint256 id) public {
        require(!applications[id].approved && !applications[id].rejected, "Application already processed");
        applications[id].approved = true;
        emit ApplicationApproved(id);
    }

    function rejectApplication(uint256 id) public {
        require(!applications[id].approved && !applications[id].rejected, "Application already processed");
        applications[id].rejected = true;
        emit ApplicationRejected(id);
    }
}