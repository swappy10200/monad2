// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract PrioritizedTaskManager {
    struct Task {
        string description;
        uint8 priority;
        address assignee;
        bool completed;
    }

    mapping(uint256 => Task) public tasks;
    uint256 public taskCount;

    event TaskCreated(uint256 id, string description, uint8 priority, address assignee);
    event TaskCompleted(uint256 id);

    function createTask(string memory description, uint8 priority, address assignee) public {
        tasks[taskCount] = Task(description, priority, assignee, false);
        emit TaskCreated(taskCount, description, priority, assignee);
        taskCount++;
    }

    function completeTask(uint256 id) public {
        require(tasks[id].assignee == msg.sender, "Only the assignee can complete the task");
        tasks[id].completed = true;
        emit TaskCompleted(id);
    }
}