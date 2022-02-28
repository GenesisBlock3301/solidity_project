// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;


contract SimpleStorage{
    
    uint256 storeData;
    
    function setData(uint256 x) public{
        storeData = x;
    }
    
    function getData() public view returns(uint256){
        return storeData;
    }
}