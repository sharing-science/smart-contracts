pragma solidity ^0.6.0;

contract Front_end_Control {
  function getClauseCount() public view returns (uint256) {
    return clauseCount;
  }

  function getClause(uint256 num) public view returns (string memory) {
    return clauses[num].content;
  }

  function getClauseStatus(uint256 id) public view returns (bool) {
    return clauses[id].agree;
  }

  function getReportCount() public view returns (uint256) {
    return reportCount;
  }

  function getReportId(uint256 num) public view returns (uint256) {
    return Reports[num].id;
  }

  function getReportType(uint256 num) public view returns (string memory) {
    return Reports[num].reportType;
  }

  function getReportAccount(uint256 num) public view returns (string memory) {
    return Reports[num].reportAccount;
  }

  function getReportReason(uint256 num) public view returns (string memory) {
    return Reports[num].reportReason;
  }

  function getStateName() public view returns (string memory){
    return stateName;
  }

  function getClauseAgree(uint i) public view returns (bool) {
    return clauses[i].agree;
  }

  function getNumber() public view returns (uint){
    return Number;
  }

}