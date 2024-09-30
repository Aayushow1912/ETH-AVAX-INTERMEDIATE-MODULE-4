// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {

    struct Item {
        string name;
        uint8 itemId;
        uint256 price;
    }
    mapping (uint8=>Item) items;
    mapping (address=>Item[]) playerItems;
    uint8 public tokenId;
    
    event ItemPurchased(address indexed buyer, uint8 itemId, string itemName, uint256 price);
    event GameOutcome(address indexed player, uint256 num, bool won, string result);

    constructor (address initialOwner, uint tokenSupply) ERC20("Degen", "DGN") Ownable(initialOwner) {
        mint(initialOwner, tokenSupply);
        
        items[1] = Item("Beginner's Beacon", 1, 100);
        items[2] = Item("Epic Explorer", 2, 700);
        items[3] = Item("Galactic Guardian", 3, 1200);
        items[4] = Item("Stellar Sentinel", 4, 2200);
        items[5] = Item("Ultimate Overlord", 5, 2400);
        tokenId = 6;

    }

    function decimals() override public pure returns (uint8){
        return 0;
    }

    // Minting tokens

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Transferring tokens

    function transferToken(address _recipient, uint _amount) external {
        require(balanceOf(msg.sender)>=_amount, "Insufficient balance");
        transfer(_recipient, _amount);
    }

    // Redeeming tokens

    function welcomeBonus() public {
        require(balanceOf(msg.sender) == 0, "You've already claimed your welcome bonus");
        _mint(msg.sender, 50);
    }

    function addItem(string memory _name, uint256 _price) public onlyOwner {
        items[tokenId] = Item(_name, tokenId,_price);
        tokenId++;
    } 

    function isLessThanFive(bool _prediction, uint256 _betAmount) public {
        uint randomNumber = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 10;

        if (_prediction ==(randomNumber<5)) {
            _mint(msg.sender, _betAmount*2);
            emit GameOutcome(msg.sender, randomNumber, true, "won");

        } else {
            burn(_betAmount);
            emit GameOutcome(msg.sender, randomNumber, false, "lost");
        }
    }
    
    function purchaseItem(uint8 _itemId) external {
        require(items[_itemId].price != 0, "Item not found");
        require(balanceOf(msg.sender) >= items[_itemId].price, "Insufficient balance");

        burn(items[_itemId].price);
        playerItems[msg.sender].push(items[_itemId]);

        emit ItemPurchased(msg.sender, _itemId, items[_itemId].name, items[_itemId].price);
    }

    function getUserItems(address user) external view returns (uint8[] memory) {
        Item[] memory itemsList = playerItems[user];
        uint length = itemsList.length;

        uint8[] memory _ids = new uint8[](length);

        for (uint i = 0; i < length; i++) {
            _ids[i] = itemsList[i].itemId;
        }

        return _ids;
    }
    function getItemName(uint8 _id) external  view returns (string memory) {
        return items[_id].name;
    }
    function getItemPrice(uint8 _id) external  view returns(uint){
        return items[_id].price;
    }


    // Checking token balance

    function getBalance() external view returns(uint256){
        return balanceOf(msg.sender);
    }

    // Burning tokens

    function burnToken(uint _amount) external {
        require(balanceOf(msg.sender)>=_amount, "Insufficient amount");
        burn(_amount);
    }

}
