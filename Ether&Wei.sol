// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;


contract EthUnit{
    
    uint256 public oneWei = 1 wei;
    
    bool public isOneWei = oneWei == 1;
    
    uint256 oneEther = 1 ether;
    bool public isOneEther = 1 ether == 1e18;
}