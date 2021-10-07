// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Main {
    uint256 clauseCount = 0;
    uint256 stateCount = 0;
    uint256 reportCount = 0;
    truct Clause {
        uint256 id;
        string content;
        bool agree;
    }

    struct State {
      uint id;
      string name;
    }

    mapping(uint => State) public ContractStates;

    string public stateName;
    uint public Number=0;

    struct Report {
      uint256 id;
      string reportType;
      string reportAccount;
      string reportReason;
    }

    mapping(uint => Report) public Reports;
}