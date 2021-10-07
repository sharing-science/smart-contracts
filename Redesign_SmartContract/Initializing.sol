pragma solidity ^0.6.0;

contract Initializing {
  Main main_contract = Test(0x123abc...);  // address of deployed A

  function createClause(string memory _content) public {
    clauseCount++;
    clauses[clauseCount] = Clause(clauseCount, _content, false);
    emit ClauseCreated(clauseCount, _content, false);
  }

  function createState(string memory _name) public {
    stateCount ++;
    ContractStates[stateCount] = State(stateCount,_name);
  }



}