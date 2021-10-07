pragma solidity ^0.6.0;

contract ReportControl {
  function AddReport(string memory _type, string memory _account, string memory _name) public{
    reportCount++;
    Reports[reportCount] = Report(clauseCount, _type, _account, _name);
  }

}