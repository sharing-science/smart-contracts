pragma solidity ^0.6.0;
import "./main.sol";

contract Initializing {
  //Main main_contract = Test(0x123abc...);  // address of deployed A
  Main public mainController;

  constructor(Main _mainController) public {
    mainController=_mainController;
  }

  function createClause(string memory _content) public {
    mainController.clauseCount++;
    
    mainController.clauses[clauseCount] = mainController.Clause(clauseCount, _content, false);
    emit ClauseCreated(clauseCount, _content, false);
  }

  function createState(string memory _name) public {
    stateCount ++;
    ContractStates[stateCount] = State(stateCount,_name);
  }

}