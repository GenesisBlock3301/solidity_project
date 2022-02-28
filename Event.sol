// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Event{
    event Log(address indexed sender,string message);
    event AnotherLog();

    function test() public{
        emit Log(msg.sender,"Hello world");
        emit Log(msg.sender,"Hello evm");
        emit AnotherLog();
    }
}