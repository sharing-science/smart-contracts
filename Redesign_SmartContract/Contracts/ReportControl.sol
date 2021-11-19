pragma solidity ^0.6.0;
import "./main.sol";

contract ReportControl {
  Main public mainController;
  constructor(Main _mainController) public {
    mainController=_mainController;
  }

  function AddReport(string memory _type, string memory _account, string memory _name) public{
    mainController.reportCount++;
    mainController.Reports[reportCount] = mainController.Report(clauseCount, _type, _account, _name);
  }

}