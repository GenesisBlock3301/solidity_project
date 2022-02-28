// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Car{
    address public owner;
    string public model;
    address public carAddr;

    constructor(address _owner,string memory _model) payable{
        owner = _owner;
        model = _model;
        carAddr = address(this);
    }
}

contract CarFactory{
    Car[] public cars;

    function create(address _owner,string memory _model) public{
        Car car = new Car(_owner,_model);
        cars.push(car);
    }

// create contract and send ether.
    function createSendEther(address _owner,string memory _model) public payable{
        Car car = (new Car){value:msg.value}(_owner,_model);
    }

    function getCar(uint _index) public view returns(
        address owner,
        string memory model,
        address carAddr,
        uint balance
        ){
            Car car = cars[_index];
            return(car.owner(),car.model(),car.carAddr(),address(car).balance);
        }

}