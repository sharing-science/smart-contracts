contract Covid19usecase{
    //participating entities with Ethereum addresses
    address public data_contributor; 
    address public user; 
    string public content;//description of container content
    bytes32 public passphrase; //recived passphrase when money is deposited
    string public receivedCode; //recived code to be hashed
    enum contractState { 
        NotReady, Created, ReadyforRequireRequest, ReadyforSubmitRequest, ReadyforReview, Active, Inactive, Aborted, Terminate
    }   
    contractState public state; 
    uint startTime;
    uint daysAfter;
    int request_approval_result;
    
    
    //contructor
    function Covid19usecase(){
        startTime = block.timestamp;
        data_contributor = 0x583031d1113ad414f02576bd6afabfb302140225;//address of data_contributor
        user = 0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db;
        state = contractState.Inactive;
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
    
    
    function CreateContract() onlyContributor {
        require(state == contractState.NotReady);
            state = contractState.ReadyforRequireRequest;
            
    }
    
    
    function RequireRequest() onlyContributor {
        require(state == contractState.ReadyforRequireRequest);
            state = contractState.ReadyforSubmitRequest; 
            
    }
    
    function UserSubmitRequest() onlyUser {
        require(state == contractState.ReadyforSubmitRequest);
            state = contractState.ReadyforReview;
    }
    
    function ApproveRequest(int result) onlyContributor {
        require(state == contractState.ReadyforReview);
        request_approval_result = result;
        if(request_approval_result == 1){//indicating the request has been approved
            state = contractState.Active;
            RequestApprovalDone("Self Check result is Success");//trigger event with result
        }
        else if(request_approval_result == 0){
            state = contractState.Aborted;
            RequestApprovalDone("Contract Aborted: Failure."); //trigger event with result
            selfdestruct(msg.sender);
        }
            
    } 
    
    
}