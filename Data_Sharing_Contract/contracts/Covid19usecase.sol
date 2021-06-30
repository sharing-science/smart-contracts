pragma solidity ^0.5.0;
//import "./BiomedicalDataToken.sol";

contract Covid19usecase{
  uint clauseCount = 0;

  struct Clause {
    uint id;
    string content;
    bool agree;

  }

  enum contractState { 
    NotReady, Created, ReadyforRequireRequest, ReadyforSubmitRequest, ReadyforReview, Active, Inactive, Aborted, Terminate, Expire
  } 

  contractState public State;


  constructor() public {
    createClause("For each proposed Research Project, User(s) agree(s) to submit a Data Use Request to the Data Access Committee for review and approval to access the Data.");
    createClause("User(s) agree(s) to not attempt to contact any individuals who are the subjects of the Data, any known living relatives, any Data Contributors, or healthcare providers unless required by law to maintain public health and safety. User(s) agree to report any unauthorized access use(s) or disclosure(s) of the Data by other users (collaborator) to the Data Access Committee no later than 2 business days after discovery. The occurrence of a Data Access Incident is ground for suspension of fifteen days of any access to Data.");
    createClause("Except as required by law, User(s) shall not grant access to the Data to any third party without the prior written permission submitted by the users to the Data Access Committee. User(s) agree to report any unauthorized access use(s) or disclosure(s) of the Data by the third party to the Data Access Committee no later than 2 business days after discovery. The occurrence of a Data Access Incident is ground for termination of any access to Data.");
    createClause("The Data Use Request will remain in effect for a period of five (5) years from the Data Use Request Effective Date and will automatically expire at the end of this period unless terminated or renewed.");
    createClause("User(s) agree(s) to recognize the effort that Data Contributor(s) made in collecting and providing the Data and allow the following information in the approved Data Use Request to be made publicly available: non-confidential research statement of the Research Project, Project Title, Users’ names and Accessing Institution(s)");
    State=contractState.NotReady;
  }

  mapping(uint => Clause) public clauses;

  event ClauseCreated(
    uint id,
    string content,
    bool agree
  );

  event RequestSumbitted(
    uint id
  );

  function getClauseCount() public view returns (uint){
    return clauseCount;
  }

  function getState() public view returns (contractState){
    return State;
  }

  function createClause(string memory _content) public {
    clauseCount ++;
    clauses[clauseCount] = Clause(clauseCount, _content, false);
    emit ClauseCreated(clauseCount, _content, false);
  }

  function agreeClause1(bool agree) public {
    if(agree) {
      State=contractState.ReadyforRequireRequest;
    }
  }

  function submitRequest(uint _id) public {
    State=contractState.ReadyforReview;
    emit RequestSumbitted(_id);
  }
}