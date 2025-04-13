// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract InventoryManager {
    struct Item {
        string name;
        uint256 quantity;
        address supplier;
    }

    mapping(uint256 => Item) public items;
    uint256 public itemCount;

    event ItemAdded(uint256 id, string name, uint256 quantity, address supplier);
    event ItemUpdated(uint256 id, uint256 newQuantity);

    function addItem(string memory name, uint256 quantity, address supplier) public {
        items[itemCount] = Item(name, quantity, supplier);
        emit ItemAdded(itemCount, name, quantity, supplier);
        itemCount++;
    }

    function updateItem(uint256 id, uint256 newQuantity) public {
        require(items[id].supplier == msg.sender, "Only the supplier can update the item");
        items[id].quantity = newQuantity;
        emit ItemUpdated(id, newQuantity);
    }
}