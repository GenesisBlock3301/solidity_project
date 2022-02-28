pragma solidity >=0.4.16 <0.9.0;

contract Account{
    uint public balance;
    uint public constant MAX_UINT = 2**256-1;
    
    function deposit(uint256 _amount) public{
        uint256 oldBalance = balance;
        uint256 newBalance = balance + _amount;
        require(newBalance >= oldBalance,"Overflow");
        balance = newBalance;
        assert(balance >= oldBalance);
    }
    
    
    function withdraw(uint256 _amount) public{
        
        uint256 oldBalance = balance;
        
        require(balance >= _amount,"Underflow");
        if(balance < _amount){
            revert("Underflow");
        }
        balance-=_amount;
        assert(balance <= oldBalance);
    }
}