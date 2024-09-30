# ERC-20 Degen Token Contract

This Solidity program demonstrates an ERC-20 Token with support for the transfer, minting, and burning of tokens, as well as additional gaming and in-game item functionalities.

## Description

The Solidity contract `DegenToken` defines an ERC-20 token with essential functionalities such as minting, burning, and transferring tokens. It also includes a system for purchasing and redeeming in-game items. Additionally, users can participate in a simple game where they bet tokens on random outcomes. The contract uses the OpenZeppelin library for security and follows the ERC-20 standard.

# Contract Overview
The `DegenToken` contract is a basic implementation of an ERC-20-like token with additional game-related features. It includes the following components:

1) **`owner`**: The owner's address is set when the contract is deployed, allowing them to mint new tokens and add game items.

2) **`items`**: A mapping that stores in-game items available for purchase using tokens, each with a unique `itemId`, name, and price.

3) **`playerItems`**: A mapping that tracks which items have been purchased by each user.

# Usage

### Constructor

The contract constructor initializes the token with an initial supply and assigns the deploying address as the owner. The owner can also mint new tokens or add in-game items.

Functions

mint(address to, uint256 amount);
// Allows the contract owner to mint new tokens and add them to a specified address's balance.

burn(uint256 amount);
// Allows users to burn (destroy) a specific amount of their tokens.

transferToken(address recipient, uint256 amount);
// Allows users to transfer a specified amount of tokens from sender to recipient.

wel_Bonus();
// Allows new users to claim a welcome bonus of 50 tokens, but only if they have a zero balance.

add_Item(string memory _name, uint256 _price);
// Allows the owner to add new in-game items to the system, with a unique ID and price in tokens.

LessThanFive(bool _prediction, uint256 _betAmount);
// A simple game where users bet tokens on whether a random number (0-9) is less than 5. Winners double their bet.

purchase_Item(uint8 _itemId);
// Allows users to purchase in-game items using tokens, reducing their balance and storing the purchased items in `playerItems`.

get_User_Items(address user) external view returns (uint8[] memory);
// Returns a list of item IDs purchased by a specific user.

get_Item_Name(uint8 _id) external view returns (string memory);
// Retrieves the name of a specific item by its itemId.

get_Item_Price(uint8 _id) external view returns (uint256);
// Retrieves the price of a specific item by its itemId.

get_Balance() external view returns (uint256);
// Allows users to check their token balance.

burn_Token(uint _amount) external;
// Allows users to burn a specified amount of their tokens.

Getting Started
Installation
Open in Remix

Executing Program
To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at Remix Ethereum.


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    // Contract details here
}

## Help
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.20" (or another compatible version), and then click on the "Compile DegenToken.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "DegenToken" contract from the dropdown menu, and then click on the "Deploy" button.

## Authors

Aayush Tewari
