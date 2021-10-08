// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;


contract HotelRoom{
    
    enum Statuses{ Vacant, Occupied }
    Statuses currentStatus;  
    address payable public owner;
    
    
    event Occupy(address _occupant,uint256 _value);
    
    constructor() public{
        owner = msg.sender;
        currentStatus = Statuses.Vacant;
    }
    
    modifier onlyWhileVacant{
        require(currentStatus == Statuses.Vacant,"Currently Occupied");
        _;
    }
    
    modifier cost(uint256 _amount){
         require(msg.value >= _amount,"Not enough ether provided.");
         _;
    }
    
    function book() payable onlyWhileVacant cost(2 ether) public{
        
        // require(msg.value >= 2 ether,"Not enough ether provided.");
        
        // require(currentStatus == Statuses.Vacant,"Currently Occupied.");
        
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender,msg.value);
        
    }
}