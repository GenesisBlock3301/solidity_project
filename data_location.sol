pragma solidity >=0.4.16 <0.9.0;

contract DataLocation{
    
    uint256 [] public arr;
    mapping(uint256=>address) map;
    
    struct Mystruct{
        uint256 foo;
    }
    
    mapping(uint256=>Mystruct) myStructs;
    
    function f() public{
        _f(arr,map,myStructs[1]);
    }
    
    function _f(uint256[] storage _arr,mapping(uint256=>address) storage _map,Mystruct storage _myStruct) internal{
        
    }
}