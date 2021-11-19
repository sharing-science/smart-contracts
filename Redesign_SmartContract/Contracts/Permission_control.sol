pragma solidity ^0.6.0;
import "./main.sol";

contract Permission_control {
    Main public mainController;

    constructor(Main _mainController) public {
      mainController=_mainController;
    }

    function acceptClause(uint256 id) public {
      mainController.clauses[id].agree = true;
    }

    function changeState(uint id) public {
      mainController.stateName=mainController.ContractStates[id].name;
      //Number=1;
    }
  
}