// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract ProjectManager {
    struct Project {
        string name;
        string description;
        uint256 startDate;
        uint256 endDate;
        address manager;
        bool completed;
    }

    mapping(uint256 => Project) public projects;
    uint256 public projectCount;

    event ProjectCreated(uint256 id, string name, string description, uint256 startDate, uint256 endDate, address manager);
    event ProjectCompleted(uint256 id);

    function createProject(string memory name, string memory description, uint256 startDate, uint256 endDate) public {
        require(startDate < endDate, "Start date must be before end date");
        projects[projectCount] = Project(name, description, startDate, endDate, msg.sender, false);
        emit ProjectCreated(projectCount, name, description, startDate, endDate, msg.sender);
        projectCount++;
    }

    function completeProject(uint256 id) public {
        require(projects[id].manager == msg.sender, "Only the project manager can complete the project");
        projects[id].completed = true;
        emit ProjectCompleted(id);
    }
}