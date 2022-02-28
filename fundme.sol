// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe{
    mapping(address=>uint256) public addressToAmountFunded;
    AggregatorV3Interface public priceFeed;
    address public owner;
    address[] public funders;
    mapping(address=>bool) isOwner;

    constructor(){
        owner = msg.sender;
    }

    function fund() public payable{
        uint256 minimumUSD = 50 * 10**18;
        require(
            getConversionRate(msg.value) >= minimumUSD,
            "You need to spend more ETH!"
        );
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,
        ) = priceFeed.latestRoundData();
        // 310215805736 current price of ethereum.
        return uint256(answer*10000000000);
    }

    function getConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUsd;
        // 3110787962710
    }
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyAssignOwner(){
        require(isOwner[msg.sender]==true);
        _;
    }

    function withdraw() public payable onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }

    function AssignOwner(address _newOwner) public onlyOwner{
        isOwner[_newOwner] = true;
    }

    function DeleteOwner(address _deleteOwner) public onlyOwner{
        require(isOwner[_deleteOwner],"This is not a owner");
        delete isOwner[_deleteOwner];
    }

    function witdrawByAssignee() public payable onlyAssignOwner{
        // require(address(this).balance < amount,"Moment won't be more than balance");
        // require(amount <= 5,"You can't withdraw more than that.");
        // payable(msg.sender).transfer(amount);
        payable(msg.sender).transfer(address(this).balance);
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }
    

}