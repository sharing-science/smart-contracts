pragma solidity ^0.4.0;
contract Covid19usecase{
    address public data_contributor; 
    address public user; 
    enum contractState { 
        NotReady, Created, ReadyforRequireRequest, ReadyforSubmitRequest, ReadyforReview, Active, Inactive, Aborted, Terminate, Expire
    }   
    contractState public state; 
    uint startTime;
    uint daysAfter;
    int request_approval_result;
    uint remainTime;
    Contributor[] public contributor;
    
    struct Contributor {
        string _firstName;
        string _lastName;
    }
    
    //contructor
    constructor() public{
        startTime = block.timestamp;
        daysAfter = 1825; //5 years
        data_contributor = msg.sender;//address of sender
        user = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
        state = contractState.NotReady;
        request_approval_result = 0;
    }
    
    //modifiers
    modifier onlyUser() {
        require(msg.sender == user, "Only user can call this.");
        _;
    }
    modifier onlyContributor() {
        require(msg.sender == data_contributor, "Only data contributor can call this.");
        _;
    }
    modifier inState(contractState _state) {
        require(state == _state, "Invalid state.");
        _;
    }
    
    event RequestApprovalDone(string msg);//to announce result if the request submitted by users could be approved.
    //event ShowRemainingTime(uint remainingTime); 
    
    function addcontributor(string memory _firstName, string memory _lastName) public onlyContributor{
        contributor.push(Contributor(_firstName,_lastName));
    }
    
    //Clause1
    //For each proposed Research Project, User(s) agree(s) to submit a Data Use Request to the Data Access Committee 
    //for review and approval to access the Data.
    function CreateContract() public onlyContributor {
        require(state == contractState.NotReady);
            state = contractState.ReadyforRequireRequest; //once locked the container will do a self check on the sensors
            //RequireRequest(msg.sender); //trigger event
    }
    
    
    function RequireRequest() public onlyContributor {
        require(state == contractState.ReadyforRequireRequest);
            state = contractState.ReadyforSubmitRequest; //once locked the container will do a self check on the sensors
            
    }
    
    function UserSubmitRequest() public onlyUser {
        require(state == contractState.ReadyforSubmitRequest);
            state = contractState.ReadyforReview;
    }
    
    function ApproveRequest(int result) public onlyContributor {
        require(state == contractState.ReadyforReview);
        request_approval_result = result;
        if(request_approval_result == 1){ //request is approved.
            state = contractState.Active;
            emit RequestApprovalDone("Request is Approved");
        }
        else if(request_approval_result == 0){ //request is not qpproved.
            state = contractState.Aborted;
            emit RequestApprovalDone("Contract Aborted: Failure.");
             selfdestruct(msg.sender);
        }
            
    }
    
    //Clause4
    //The Data Use Request will remain in effect for a period of five (5) years from the Data Use Request Effective Date 
    //and will automatically expire at the end of this period unless terminated or renewed.
    function terminateRequest() public {
        require(state == contractState.Active);
           state = contractState.Terminate;
           
    }
    
    function renewed() public {
        startTime=block.timestamp;
    }
    
    function DetectValid() public {
        require(state == contractState.Active);
        if(block.timestamp > startTime + daysAfter * 1 days){
            state = contractState.Expire;
        }
    }
    
    function ShowRemainingTime() public {
        require(state == contractState.Active);
          remainTime=(daysAfter * 1 days)-(block.timestamp-startTime);
    }
    
    
}