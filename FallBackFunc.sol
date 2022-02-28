// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
// fallback() and receive()

//      Ether is sent to contract
//                |
//          is msg.data empty
//               / \
//              yes
contract FallBack{
    event Log(string func, address sender, uint value, bytes data);
    fallback() external payable{}

    receive() external payable{}

}