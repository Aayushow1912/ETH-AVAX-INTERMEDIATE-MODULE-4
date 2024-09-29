// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DegenToken is ERC20, Ownable {
    mapping(uint256 => uint256) public itemPrices; // Mapping of item IDs to their prices

    constructor() ERC20("DegenTKN", "DGN") {
        // Mint an initial supply of tokens to the contract deployer (owner)
        _mint(msg.sender, 1000000 * 10 ** uint(decimals())); // Adjust the initial supply as needed
    }

    // Mint new tokens, only callable by the owner
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Transfer tokens to another address
    function transferTokens(address to, uint256 amount) public {
        require(to != address(0), "Invalid address");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _transfer(msg.sender, to, amount);
    }

    // Redeem tokens for items in the in-game store
    function redeemTokens(uint256 itemId) public {
        require(itemPrices[itemId] > 0, "Invalid item ID"); // Check if the item exists
        uint256 price = itemPrices[itemId];
        require(balanceOf(msg.sender) >= price, "Insufficient balance");

        // Implement logic to deliver the item to the player here.
        // For this example, we'll simply deduct the tokens from the player's balance.
        _burn(msg.sender, price);
    }

    // Add an item with a specific price to the in-game store
    function addItemToStore(uint256 itemId, uint256 price) public onlyOwner {
        itemPrices[itemId] = price;
    }

    // Check token balance of an address
    function getTokenBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    // Burn tokens that are no longer needed
    function burnTokens(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _burn(msg.sender, amount);
    }
}
