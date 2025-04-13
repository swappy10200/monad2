// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @title EventManager
 * @dev A contract to manage events
 */
contract EventManager {
    struct Event {
        string name;
        uint256 date;
        string location;
        bool isActive;
    }

    address public owner;
    mapping(uint256 => Event) public events;
    uint256 public eventCount;

    /**
     * @dev Sets the contract deployer as the owner
     */
    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Modifier to check if caller is the owner
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    /**
     * @dev Create a new event
     * @param name The name of the event
     * @param date The date of the event
     * @param location The location of the event
     */
    function createEvent(string memory name, uint256 date, string memory location) public onlyOwner {
        events[eventCount] = Event(name, date, location, true);
        eventCount++;
    }

    /**
     * @dev Cancel an event
     * @param eventId The ID of the event to cancel
     */
    function cancelEvent(uint256 eventId) public onlyOwner {
        require(eventId < eventCount, "Event does not exist");
        events[eventId].isActive = false;
    }

    /**
     * @dev Get event details
     * @param eventId The ID of the event
     * @return name The name of the event
     * @return date The date of the event
     * @return location The location of the event
     * @return isActive Whether the event is active
     */
    function getEvent(uint256 eventId) public view returns (string memory, uint256, string memory, bool) {
        require(eventId < eventCount, "Event does not exist");
        Event memory eventInfo = events[eventId];
        return (eventInfo.name, eventInfo.date, eventInfo.location, eventInfo.isActive);
    }
}