// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

// NOTE: Deploy this contract first
contract B{
    //NOTE: storage layout must be the same as contract a
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable{
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract A{
     uint public num;
    address public sender;
    uint public value;

    function setVars(address _contract,uint _num) public payable{
        (bool success,bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)",_num)
        );
    }
}