pragma solidity ^0.6.0;

contract Permission_control {
    function acceptClause(uint256 id) public {
      clauses[id].agree = true;
    }

    function changeState(uint id) public {
      stateName=ContractStates[id].name;
      //Number=1;
    }
  
}