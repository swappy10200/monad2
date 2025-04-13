// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract CategorizedTaskManager {
    struct Task {
        string description;
        string category;
        address assignee;
        bool completed;
    }

    mapping(uint256 => Task) public tasks;
    uint256 public taskCount;

    event TaskCreated(uint256 id, string description, string category, address assignee);
    event TaskCompleted(uint256 id);

    function createTask(string memory description, string memory category, address assignee) public {
        tasks[taskCount] = Task(description, category, assignee, false);
        emit TaskCreated(taskCount, description, category, assignee);
        taskCount++;
    }

    function completeTask(uint256 id) public {
        require(tasks[id].assignee == msg.sender, "Only the assignee can complete the task");
        tasks[id].completed = true;
        emit TaskCompleted(id);
    }
}