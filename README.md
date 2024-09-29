# DegenToken Smart Contract 

The DegenToken Smart Contract is an Ethereum-compatible smart contract written in Solidity, designed to be deployed on the Avalanche Fuji testnet. It implements an ERC-20 token with added functionalities, such as minting, transferring, and burning tokens, as well as an in-game store where tokens can be redeemed for items.

## Features

### ERC-20 Token Standard

This contract adheres to the ERC-20 token standard, providing basic token functionalities, including transfers, balance inquiries, and allowance management.

### Minting Tokens

The contract owner has the exclusive right to mint additional tokens using the `mint` function. This allows the owner to create new tokens and distribute them to specific accounts.

### Transferring Tokens

Users can transfer tokens to different addresses using the `transferTokens` function. It checks for a valid recipient address, sufficient balance, and a non-zero transfer amount.

### Redeeming Tokens for Items

The contract includes a feature to redeem tokens for items in an in-game store. Users can specify an item ID and, if the item exists and they have a sufficient balance, they can redeem the item. The example contract logic deducts tokens from the user's balance for this purpose.

### Adding Items to the Store

The contract owner can add items to the in-game store by specifying an item ID and its price using the `addItemToStore` function.

### Checking Token Balances

Users can check their token balances using the `getTokenBalance` function, which provides the balance of tokens for a given address.

### Burning Tokens

Users can burn their own tokens using the `burnTokens` function, which reduces their token balance by a specified amount, provided they have a sufficient balance.

## Contract Deployment on Avalanche Fuji Testnet

To deploy this contract on the Avalanche Fuji testnet, follow these steps:

1. Make sure you have access to an Avalanche wallet compatible with the Fuji testnet.
2. Compile the contract code using a Solidity compiler compatible with Avalanche, and obtain the compiled bytecode.
3. Deploy the contract to the Avalanche Fuji testnet using your Avalanche wallet's deployment functionality.
4. After deployment, interact with the contract using Avalanche-compatible tools and wallets.

## Prerequisites

- Solidity ^0.8.12 (compatible with Avalanche)
- Avalanche-compatible wallet for deploying and interacting with the contract

## Author

Aayush Tewari

Chandigarh University
