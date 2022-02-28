// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Enum {
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    Status public status;
    function get() public view returns(Status){
        return status;
    }

    // update status
    function set(Status _status) public{
        status = _status;
    }
    // update specific enum
    function cancel() public{
        status = Status.Canceled;
    }

    // delete reset the enum to ots first value,0
    function reset() public{
        delete status;
    }
    
}
