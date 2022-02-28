// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;


contract Variables{
    // state Variables are store outside function,inside contract
    string public text = "Hello";
    uint public num = 123;
    
    // constant variable cannot be modified
    address public constant my_address = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    
    
    function doSomething() public{
        // local variable
        uint i = 667;
        
        // here are some global variable
        uint timeStamp = block.timestamp; // Current block timestamp.
        address sender = msg.sender; //address of the caller.
        
        
    }
}