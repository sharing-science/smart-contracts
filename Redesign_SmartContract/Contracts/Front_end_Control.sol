pragma solidity ^0.6.0;
import "./main.sol";

contract Front_end_Control {
  Main public mainController;

  constructor(Main _mainController) public {
    mainController=_mainController;
  }
  function getClauseCount() public view returns (uint256) {
    return mainController.clauseCount;
  }

  function getClause(uint256 num) public view returns (string memory) {
    return mainController.clauses[num].content;
  }

  function getClauseStatus(uint256 id) public view returns (bool) {
    return mainController.clauses[id].agree;
  }

  function getReportCount() public view returns (uint256) {
    return mainController.reportCount;
  }

  function getReportId(uint256 num) public view returns (uint256) {
    return mainController.Reports[num].id;
  }

  function getReportType(uint256 num) public view returns (string memory) {
    return mainController.Reports[num].reportType;
  }

  function getReportAccount(uint256 num) public view returns (string memory) {
    return mainController.Reports[num].reportAccount;
  }

  function getReportReason(uint256 num) public view returns (string memory) {
    return mainController.Reports[num].reportReason;
  }

  function getStateName() public view returns (string memory){
    return mainController.stateName;
  }

  function getClauseAgree(uint i) public view returns (bool) {
    return mainController.clauses[i].agree;
  }

  function getNumber() public view returns (uint){
    return mainController.Number;
  }

}