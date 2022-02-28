pragma solidity >=0.4.16 <0.9.0;

contract SurveyStatement {
    uint256 public counter;
    uint256 public totalStatement;
    uint256 public counterFiles;


    struct Statement1 {
        uint256 id;
        uint256 userId;
        uint256 category_id;
        uint256 objectId;
        uint256 surveyAreaId;
        string longitude;
        string latitude;
    }
    

    struct Statement2 {
        uint256 id;
        uint256 category_id;
        uint256 objectId;
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
    mapping(uint256 => mapping(uint256 => Statement1[])) public Statements1;
    mapping(uint256 => mapping(uint256 => Statement2[])) public Statements2;
    // mapping(uint256 => mapping(uint256 => Statement3[])) public Statements3;
    mapping(uint256 => StatementFiles[]) public statementfiles;

    constructor() public {
        totalStatement = 0;
        counter = 0;
        counterFiles = 0;
    }


    function setStatment1(
        uint256 _surveyAreaId,
        uint256 _category_id,
        uint256 _objectId,
        uint256 userId,
        string memory longitude,
        string memory latitude
    ) public {
        counter++;
        Statements1[_category_id][_objectId].push(
            Statement1( counter, _category_id, _objectId, _surveyAreaId, userId, longitude, latitude )
        );
    }
    
    // function setStatement2(
    //     uint256 _category_id,
    //     uint256 _objectId,
    //     string memory _longitude,
    //     string memory _latitude
        
    // ) public{
    //     Statements2[_category_id][_objectId].push(
    //         Statement2(
    //             counter,
    //             _category_id,
    //             _objectId,
    //             _longitude,
    //             _latitude
    //         )
    //     );
        
    // }

    function setStatement2(
        uint256 _category_id, uint256 _objectId, string memory indicator1, string memory indicator2,
        string memory indicator3, string memory indicator4, string memory indicator5
    ) public{
        Statements2[_category_id][_objectId].push(
            Statement2(
                counter, _category_id, _objectId,
                indicator1, indicator2, indicator3, indicator4, indicator5
            )
        );
        totalStatement++;
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
}