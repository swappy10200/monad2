// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract EventManager {
    struct Event {
        string name;
        string location;
        uint256 date;
        address organizer;
        bool cancelled;
    }

    mapping(uint256 => Event) public events;
    uint256 public eventCount;

    event EventCreated(uint256 id, string name, string location, uint256 date, address organizer);
    event EventCancelled(uint256 id);

    function createEvent(string memory name, string memory location, uint256 date) public {
        events[eventCount] = Event(name, location, date, msg.sender, false);
        emit EventCreated(eventCount, name, location, date, msg.sender);
        eventCount++;
    }

    function cancelEvent(uint256 id) public {
        require(events[id].organizer == msg.sender, "Only the organizer can cancel the event");
        events[id].cancelled = true;
        emit EventCancelled(id);
    }
}