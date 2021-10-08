// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;
pragma experimental ABIEncoderV2;


contract VotingSystem{
    
    struct Voter{
        bool is_voted;
        uint vote;
    }
    
    struct Candidate{
        bytes32 name;
        uint votes;
    }
    
    
    mapping(address=>Voter) private voters;
    
    Candidate[] private candidates;
    
    bytes32 [] private allcandidateNames;
    
    string[] private stringArray;
    
    // owner of voting
    address private owner;
    
    bool private isOpen;
    
    
    function addCandidates() public {
        owner = msg.sender;
        isOpen = true;
            candidates.push(Candidate({
                name: "Nur Amin",
                votes:0
            }));
            candidates.push(Candidate({
                name: "Nas",
                votes:0
            }));
    }
    
    // make candidate 
    function MakeCandidateArray() public returns(bytes32[] memory){
        require(candidates.length > 0);
        for(uint i = 0; i < candidates.length; i++){
            allcandidateNames.push(candidates[i].name);
        }
        return allcandidateNames;
    }
    
    function viewAllcandidates() public view returns(bytes32[] memory){
        return allcandidateNames;
    }
    
    function GetSingleCandidate(uint _index) public view returns(bytes32){
        require(allcandidateNames.length > 0);
        return allcandidateNames[_index];
    }
    
    // return list of string irrelavant of project.
    
    function getArrayString() public returns(string[] memory){
        stringArray.push("SIfat");
        stringArray.push("nas");
        return stringArray;
    }
    
    // voting function can only be called once per voter.
    function Vote(uint candidateVote) public{
        
        require(isOpen);
        
        
        Voter storage currentVoter = voters[msg.sender];
        require(!currentVoter.is_voted);
        
        
        currentVoter.vote = candidateVote;
        currentVoter.is_voted = true;
        
        candidates[candidateVote].votes++;
    }
    
    // convert bytes32 to string.irrelavant of project.
    
    function bytes32ToString(bytes32 x) public returns (string memory) {
    bytes memory bytesString = new bytes(32);
    uint charCount = 0;
    for (uint j = 0; j < 32; j++) {
        byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
        if (char != 0) {
            bytesString[charCount] = char;
            charCount++;
        }
    }
    bytes memory bytesStringTrimmed = new bytes(charCount);
    for (uint j = 0; j < charCount; j++) {
        bytesStringTrimmed[j] = bytesString[j];
    }
    return string(bytesStringTrimmed);
}
    
    
    // close voting
    function ClosingVote() public{
        require(msg.sender == owner && isOpen);
        isOpen = false;
    }
    
    // counts the vote and announce which candidate will win.
    function FindWinner() public view returns(bytes32,uint){
        require(!isOpen);
        uint maxVotes = 0;
        uint winnerCandidate = 0;
        
        for (uint i=0;i < candidates.length; i++){
            if(candidates[i].votes > maxVotes){
                maxVotes = candidates[i].votes;
                winnerCandidate = i;
            }
        }
        
        return (candidates[winnerCandidate].name,candidates[winnerCandidate].votes);
    }
    
}
// ["0x666f6f0000000000000000000000000000000000000000000000000000000000", "0x6261720000000000000000000000000000000000000000000000000000000000"]