// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract TaskManager {
    struct Task {
        string description;
        address assignee;
        bool completed;
    }

    mapping(uint256 => Task) public tasks;
    uint256 public taskCount;

    event TaskCreated(uint256 id, string description, address assignee);
    event TaskCompleted(uint256 id);

    function createTask(string memory description, address assignee) public {
        tasks[taskCount] = Task(description, assignee, false);
        emit TaskCreated(taskCount, description, assignee);
        taskCount++;
    }

    function completeTask(uint256 id) public {
        require(tasks[id].assignee == msg.sender, "Only the assignee can complete the task");
        tasks[id].completed = true;
        emit TaskCompleted(id);
    }
}