// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract ActionLogger {
    struct LogEntry {
        string action;
        address actor;
        uint256 timestamp;
    }

    LogEntry[] public logs;

    event ActionLogged(string action, address actor);

    function logAction(string memory action) public {
        logs.push(LogEntry(action, msg.sender, block.timestamp));
        emit ActionLogged(action, msg.sender);
    }
}