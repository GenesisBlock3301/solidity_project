pragma solidity >=0.4.16 <0.9.0;


contract DemoCrud{
    
    struct Country{
        string name;
        string leader;
        uint256 population;
    }
    
    Country[] public countries;
    uint256 public totalCountries;
    
    constructor() public{
        totalCountries = 0;
    }
    
    event CountryEvent(string countryName,string leader,uint256 population);
    event LeaderUpdated(string countryName,string leader);
    event CountryDeleted(string countryName);
    
    function insert(string memory countryName,string memory leader,uint256 population) public returns(uint256){
        
        Country memory newCountry = Country(countryName,leader,population);
        countries.push(newCountry);
        totalCountries++;
        
        // emit event
        
        emit CountryEvent(countryName,leader,population);
        return totalCountries;
    }
    
    function UpdateLeader(string memory countryName,string memory newLeader) public returns(bool){
        for(uint256 i = 0; i < totalCountries; i++){
            if(compareString(countries[i].name,countryName)){
                countries[i].leader = newLeader;
                emit LeaderUpdated(countryName,newLeader);
                return true;
            }
        }
        return false;
    }
   
    
    function deleteCountry(string memory countryName) public returns(bool){
        require(totalCountries > 0);
        
        for(uint256 i = 0; i < totalCountries; i++){
            if(compareString(countries[i].name,countryName)){
                // pushing last into current array index which we going to delete
                countries[i] = countries[totalCountries-1];
                // now deleting last index
                delete countries[totalCountries-1];
                totalCountries--;
                countries.length--;
                emit CountryDeleted(countryName);
                return true;
            }
        } 
        return false;
    }
    
    function getCountry(string memory countryName) public view returns(string memory, string memory,uint256){
        for(uint256 i = 0; i < totalCountries; i++){
            if(compareString(countries[i].name,countryName)){
                return (countries[i].name,countries[i].leader,countries[i].population);
            }
        }
        revert("Country not found");
    }
    
    function getTotallCoutries() public view returns(uint256){
        return countries.length;
    }
     // helper function
    function compareString(string memory a, string memory b) internal pure returns(bool){
        return keccak256(abi.encode(a)) == keccak256(abi.encode(b));
    }
    
}