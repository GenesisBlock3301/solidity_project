// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20{

    constructor(string memory name,string memory symbol) ERC20(name, symbol){
        // mint 100 token to msg.sender
        // similar to
        // 1 dollar = 100cent
        // 1 token = 1*(10**18)
        _mint(msg.sender,100);
    }
}