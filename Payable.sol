// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


contract Payable{
    // payable address can receive ether
    address payable public owner;

    // payable contructor can receive  ether
    constructor() payable{
        owner = payable(msg.sender);
    }

    // Function to deposit ether into the contract
    // Call this function along with some ether
    // the balance of this contract will be automatically updated.
    function diposit() public payable{}

    // call this function along with some ether
    // The function will threw an error since this function is not payable
    function notPayable() public{}

    modifier onlyowner { if (msg.sender == owner) _; }

    // function withdraw all ether from this contract
    function withdraw() onlyowner public{
        // get amount of ether store in this contract
        uint amount = address(this).balance;
        
        // send all ether to owner
        // Owner can receive ether since address of owner is payable.
        (bool success,) = owner.call{value:amount}("");
        require(success,"Failed to send ether.");
    }




}