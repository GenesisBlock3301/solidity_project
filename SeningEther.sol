// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract ReceiveEther{

    // function to ether receive msg.data must be empty
    receive() external payable{}

    // Fallback functin is called when msg.data is not empty
    fallback() external payable{}

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
}

contract sendEther{
    function sendViaTransfer(address payable _to) public payable{
        // this function no longer recommend for transfer ether
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable{
        // Send returns a boolean value indicating success or failure
        // This function is not recommended for sending ether.
        bool send = _to.send(msg.value);
        require(send,"Failure to send ether.");
    }

    function sendViaCall(address payable _to) public payable{
        // call returns a boolean value indicating success or failure.
        // this is the current recommend method to use.
        (bool sent,bytes memory data) = _to.call{value:msg.value}("");
        require(sent,"Failed to send Ether.");
    }
}