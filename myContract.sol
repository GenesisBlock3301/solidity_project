pragma solidity >=0.4.16 <0.9.0;

contract MyToken{
    
    address public minter;
    mapping(address=>uint256) public balances;
    
    event Sent(address from,address to,uint256 amount);
    
    constructor(){
    minter = msg.sender;
    }
    
    function mint(address receiver,uint amount) public{
        require(msg.sender == minter);
        balances[receiver] += amount;
        
    }
    
    function send(address receiver,uint256 amount) public{
        require(amount <= balances[msg.sender],"Balance is insufficient");
        balances[msg.sender] -= amount;
        balances[receiver] +=amount;
        emit Sent(msg.sender,receiver,amount);
    }
}