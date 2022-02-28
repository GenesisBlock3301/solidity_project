// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


contract MultiSigWallet{
    event Deposit(address indexed sender,uint amount, uint balance);
    event SubmitTransaction(
        address indexed owner,
        uint indexed txIndex,
        address indexed to,
        uint value,
        bytes data
        );
    event ConfirmTransaction(address indexed owner,uint indexed texIndex);
    event RevokeConfirmation(address indexed owner,uint indexed texIndex);
    event ExecuteTransaction(address indexed owner,uint indexed texIndex);

    address[] owners;
    mapping(address=>bool) public isOwner;
    uint public numConfirmationsRequired;

    struct Transaction{
        address to;
        uint value;
        bytes data;
        bool executed;
        uint numConfirmations;
    }

    // mapping from tx index=>owner=> bool
    mapping(uint=>mapping(address=>bool)) public isConfirmed;

    Transaction[] public transactions;


    modifier onlyOwner(){
        require(isOwner[msg.sender],"Not owner");
        _;
    }

    modifier txExists(uint _txIndex){
        require(_txIndex < transactions.length,"Tx doesn't exists.");
        _;
    }

    modifier notExecuted(uint _txIndex){
        require(!transactions[_txIndex].executed,"Tx already executed");
        _;
    }

    modifier notConfirmed(uint _txIndex){
        require(isConfirmed[_txIndex][msg.sender],"Tx already confirmed.");
        _;
    }

    constructor(address[] memory _owner,uint _numConfirmationRequired){
        require(_owner.length > 0, "Owners required");
        require(_numConfirmationRequired > 0 && _numConfirmationRequired <= _owner.length,
        "Invalid number of required confirmation." );
        
        for(uint i=0;i<_owner.length;i++){
            address owner = _owner[i];
            require(owner != address(0),"Invalid owner");
            require(!isOwner[owner],"Owner not unique");

            isOwner[owner] = true;
            owners.push(owner);
        }
        numConfirmationsRequired = _numConfirmationRequired;
    }

    receive() external payable{
        emit Deposit(msg.sender,msg.value,address(this).balance);
    }

    function deposit() payable external{
         emit Deposit(msg.sender,msg.value,address(this).balance);
    }

    function submitTransaction(address _to,uint _value,bytes memory _data) public onlyOwner{
        uint txIndex = transactions.length;
        transactions.push(
            Transaction({
                to:_to,
                value:_value,
                data:_data,
                executed:false,
                numConfirmations:0
            })
        );
        emit SubmitTransaction(msg.sender,txIndex,_to,_value,_data);
    }

    function confirmTransaction(uint _txIndex) public 
    onlyOwner txExists(_txIndex)
    notExecuted(_txIndex)
    notConfirmed(_txIndex){
        Transaction storage transaction = transactions[_txIndex];
        require(transaction.numConfirmations >= numConfirmationsRequired,"You are not authorized to execute");
        transaction.executed = true;
        (bool success,) = transaction.to.call{value:transaction.value}(transaction.data);
        require(success,"Transaction failed");
        emit ExecuteTransaction(msg.sender,_txIndex);
    }

    function revokeConfirmation(uint _txIndex) public onlyOwner
     txExists(_txIndex)
     notExecuted(_txIndex)
     {
        Transaction storage transaction = transactions[_txIndex];
        require(isConfirmed[_txIndex][msg.sender],"Tx not confirmed!");
        transaction.numConfirmations -= 1;
        isConfirmed[_txIndex][msg.sender] = false;
        emit RevokeConfirmation(msg.sender,_txIndex);
     }


     function getOwners() public view returns(address[] memory){
         return owners;
     }

      function getTransaction(uint _txIndex)
        public
        view
        returns (
            address to,
            uint value,
            bytes memory data,
            bool executed,
            uint numConfirmations
        )
    {
        Transaction storage transaction = transactions[_txIndex];

        return (
            transaction.to,
            transaction.value,
            transaction.data,
            transaction.executed,
            transaction.numConfirmations
        );
    }

}
// ["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"]
// 0xdD870fA1b7C4700F2BD7f44238821C26f7392148,10000000000000000000,0x0