// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./CollaboratorControl.sol";
import "./Initializing.sol";
import "./Permission_control.sol";
import "./Front_end_Control.sol";
import "./ReportControl.sol";
import "./TimingControl.sol";

contract Main {
    uint256 clauseCount = 0;
    uint256 stateCount = 0;
    uint256 reportCount = 0;
    Initializing public Initializer;
    Permission_control public Permission_controller;
    ReportControl public ReportController;
    TimingControl public TimingController;
    CollaboratorControl public CollaboratorController;
    string content1="For each proposed Research Project, User(s) agree(s) to submit a Data Use Request to the Data Access Committee for review and approval to access the Data.";
    string content2="User(s) agree(s) to not attempt to contact any individuals who are the subjects of the Data, any known living relatives, any Data Contributors, or healthcare providers unless required by law to maintain public health and safety. User(s) agree to report any unauthorized access use(s) or disclosure(s) of the Data by other users (collaborator) to the Data Access Committee no later than 2 business days after discovery. The occurrence of a Data Access Incident is ground for suspension of fifteen days of any access to Data.";
    string content3="Except as required by law, User(s) shall not grant access to the Data to any third party without the prior written permission submitted by the users to the Data Access Committee. User(s) agree to report any unauthorized access use(s) or disclosure(s) of the Data by the third party to the Data Access Committee no later than 2 business days after discovery. The occurrence of a Data Access Incident is ground for termination of any access to Data.";
    string content4="The Data Use Request will remain in effect for a period of five (5) years from the Data Use Request Effective Date and will automatically expire at the end of this period unless terminated or renewed.";
    string content5="User(s) agree(s) to recognize the effort that Data Contributor(s) made in collecting and providing the Data and allow the following information in the approved Data Use Request to be made publicly available: non-confidential research statement of the Research Project, Project Title, Users’ names and Accessing Institution(s)";

    struct Clause {
        uint256 id;
        string content;
        bool agree;
    }

    struct State {
      uint id;
      string name;
    }

    mapping(uint => State) public ContractStates;

    mapping(uint256 => Clause) public clauses;

    string public stateName;
    uint public Number=0;

    struct Report {
      uint256 id;
      string reportType;
      string reportAccount;
      string reportReason;
    }

    mapping(uint => Report) public Reports;

    constructor(Initializing _Initializer) public {
        Initializer = _Initializer;
    }

    function initializeContract(){
      Initializer.createClause("For each proposed Research Project, User(s) agree(s) to submit a Data Use Request to the Data Access Committee for review and approval to access the Data.");
      Initializer.createClause("User(s) agree(s) to not attempt to contact any individuals who are the subjects of the Data, any known living relatives, any Data Contributors, or healthcare providers unless required by law to maintain public health and safety. User(s) agree to report any unauthorized access use(s) or disclosure(s) of the Data by other users (collaborator) to the Data Access Committee no later than 2 business days after discovery. The occurrence of a Data Access Incident is ground for suspension of fifteen days of any access to Data.");
      Initializer.createClause("Except as required by law, User(s) shall not grant access to the Data to any third party without the prior written permission submitted by the users to the Data Access Committee. User(s) agree to report any unauthorized access use(s) or disclosure(s) of the Data by the third party to the Data Access Committee no later than 2 business days after discovery. The occurrence of a Data Access Incident is ground for termination of any access to Data.");
      Initializer.createClause("The Data Use Request will remain in effect for a period of five (5) years from the Data Use Request Effective Date and will automatically expire at the end of this period unless terminated or renewed.");
      Initializer.createClause("User(s) agree(s) to recognize the effort that Data Contributor(s) made in collecting and providing the Data and allow the following information in the approved Data Use Request to be made publicly available: non-confidential research statement of the Research Project, Project Title, Users’ names and Accessing Institution(s).");
      Initializer.createState("NotReady");
      Initializer.createState("ReadyforRequireRequest");
      Initializer.createState("ReadyforSubmitRequest");
      Initializer.createState("ReadyforReview");
      Initializer.createState("Active");
      Initializer.createState("Inactive");
      stateName=ContractStates[1].name;
    }
}