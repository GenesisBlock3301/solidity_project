pragma solidity >=0.4.16 <0.9.0;

contract SurveyStatement {

    uint256 public counter;
    uint256 public totalStatement;
    uint256 public counterFiles;

    struct UINTStatement {
        uint256 id;
        uint256 category_id;
        uint256 userId;
        uint256 surveyAreaId;
    }

    struct StringStatement {
        uint256 id;
        uint256 category_id;
        string latitude;
        string longitude;
        string indicator1;
        string indicator2;
        string indicator3;
        string indicator4;
        string indicator5;
    }

     struct StatementFiles {
        uint256 id;
        uint256 statementId;
        string fileHashes;
    }

    // future implements
    // mapping(uint256=>UINTStatement[]) UintStatementArray;
    // mapping(uint256=>StringStatement[]) StringStatementArray;
    mapping(uint256 => UINTStatement) public uintStatements;
    mapping(uint256 => StringStatement) public stringStatements;
    mapping(uint256 => StatementFiles[]) public statementfiles;


    constructor() public {
        totalStatement = 0;
        counter = 0;
        counterFiles = 0;
    }


    uint256[] statements;

    function setUINTStatment(uint256 _userId, uint256 _surveyAreaId,uint256 _category_id) public {
        counter++;
        uintStatements[counter] = UINTStatement(
            counter,
            _category_id,
            _userId,
            _surveyAreaId
        );
        statements.push(counter);
    }

    function setStringStatement(
        uint256 _category_id,
        string memory latitude,
        string memory longitude,
        string memory indicator1,
        string memory indicator2,
        string memory indicator3,
        string memory indicator4,
        string memory indicator5
    ) public returns (uint256) {
        stringStatements[counter] = StringStatement(
            counter,
            _category_id,
            latitude,
            longitude,
            indicator1,
            indicator2,
            indicator3,
            indicator4,
            indicator5
        );
        totalStatement++;
        return totalStatement;
    }

    function getUINTStatement(uint256 _c_id) public view returns (uint256,uint256, uint256, uint256){
        return (
            uintStatements[_c_id].id,
            uintStatements[_c_id].category_id,
            uintStatements[_c_id].userId,
            uintStatements[_c_id].surveyAreaId
        );
    }
    
    // get statement associate with mapping key
    function getStringStatement(uint256 _c_id) public view returns (string memory,string memory,
            string memory,string memory,string memory,
            string memory, string memory
        )
    {
        return (
            stringStatements[_c_id].latitude,
            stringStatements[_c_id].longitude,
            stringStatements[_c_id].indicator1,
            stringStatements[_c_id].indicator2,
            stringStatements[_c_id].indicator3,
            stringStatements[_c_id].indicator4,
            stringStatements[_c_id].indicator5
        );
    }

    // get all statements
    function getStatements() public view returns (uint256[] memory) {
        return statements;
    }

    

    // set statement files with statement id and file hash
    function setStatementFiles(uint256 _statementId, string memory _filehash)
        public
    {
        counterFiles++;
        statementfiles[_statementId].push(
            StatementFiles(counterFiles, _statementId, _filehash)
        );
    }

    // Find list of StatementFiles from statement id and index
    function getStatementFiles(uint256 _statementId, uint256 index)
        public
        view
        returns (
            uint256,
            uint256,
            string memory
        )
    {
        return (
            statementfiles[_statementId][index].id,
            statementfiles[_statementId][index].statementId,
            statementfiles[_statementId][index].fileHashes
        );
    }

    function hello() public pure returns (string memory) {
        return "Hello sifat";
    }
}

