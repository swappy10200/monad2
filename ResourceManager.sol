// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract ResourceManager {
    struct Resource {
        string name;
        string description;
        uint256 quantity;
        address manager;
    }

    mapping(uint256 => Resource) public resources;
    uint256 public resourceCount;

    event ResourceCreated(uint256 id, string name, string description, uint256 quantity, address manager);
    event ResourceUpdated(uint256 id, uint256 newQuantity);

    function createResource(string memory name, string memory description, uint256 quantity) public {
        resources[resourceCount] = Resource(name, description, quantity, msg.sender);
        emit ResourceCreated(resourceCount, name, description, quantity, msg.sender);
        resourceCount++;
    }

    function updateResource(uint256 id, uint256 newQuantity) public {
        require(resources[id].manager == msg.sender, "Only the manager can update the resource");
        resources[id].quantity = newQuantity;
        emit ResourceUpdated(id, newQuantity);
    }
}