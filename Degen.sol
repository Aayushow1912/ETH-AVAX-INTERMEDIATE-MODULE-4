// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {

    event TokensRedeemed(address indexed redeemer, uint256 amount, string item);

    struct Item {
        string name;
        uint256 price;
        uint256 stock;
    }

    Item[] public items;

    mapping(uint256 => uint256) public itemStock;
    mapping(address => mapping(uint256 => uint256)) public userInventory;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        _initializeItems();
    }

    function _initializeItems() internal {
       items[1] = Item("Beginner's Beacon", 1, 100);
       items[2] = Item("Epic Explorer", 2, 700);
       items[3] = Item("Galactic Guardian", 3, 1200);
       items[4] = Item("Stellar Sentinel", 4, 2200);
       items[5] = Item("Ultimate Overlord", 5, 2400);
       tokenId = 6;

        // Initialize item stock mapping
        for (uint256 i = 0; i < items.length; i++) {
            itemStock[i] = items[i].stock;
        }
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function getBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function transferTokens(address _receiver, uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
        transfer(_receiver, _value);
    }

    function burnTokens(uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
        burn(_value);
    }

    function redeemTokens(uint256 _choice) external {
        require(_choice > 0 && _choice <= items.length, "Invalid choice");
        Item storage item = items[_choice - 1];
        require(itemStock[_choice - 1] > 0, "Item out of stock");
        require(balanceOf(msg.sender) >= item.price, "You do not have enough Degen Tokens to redeem this item");

        _burn(msg.sender, item.price);
        itemStock[_choice - 1]--;
        userInventory[msg.sender][_choice - 1]++;
        
        emit TokensRedeemed(msg.sender, item.price, item.name);
    }

    function storeItems() external view returns (Item[] memory) {
        return items;
    }

    function getUserInventory(address user) external view returns (uint256[] memory) {
        uint256[] memory inventory = new uint256[](items.length);
        for (uint256 i = 0; i < items.length; i++) {
            inventory[i] = userInventory[user][i];
        }
        return inventory;
    }
}
