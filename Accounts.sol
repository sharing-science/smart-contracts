contract Accounts {

    address owner;

    modifier owneronly { if (msg.sender == owner) _;}

    function setOwner(address addr) internal owneronly {
        owner = addr;
    }

    struct Account {
        bytes32 user_id;
        address user_addr;
        uint data_shared;
        uint data_received;
        uint science_index;
    }

    mapping (bytes32 => Account) public accounts;
    mapping (address => bytes32) public addr_to_id; 


    function bindEthereumAddress(address addr, bytes32 id) internal {
        addr_to_id[addr] = id;
    }

    function unbindEthereumAddress(address addr, bytes32 id) internal {
        delete addr_to_id[addr];
    }

    function register() public {
        require(addr_to_id[msg.sender] != 0);
        Account memory acc;
        acc.user_addr = msg.sender;
        acc.user_id = keccak256(acc.user_addr);
        bindEthereumAddress(acc.user_addr, acc.user_id);
    }

    function shareData(bytes32 id) private {
        accounts[id].data_shared += 1;
    }

    function receiveData(bytes32 id) private {
        accounts[id].data_received += 1;
    }

    function updateScienceIndex(bytes32 id) private {
        //INCENTIVIZE SOMEHOW????
        //SOON TO COME
        //MAYBE
        //nOT SURE HOW TO CALCULATE THIS BUT OUR sCIENCE INDEX WILL BE THE SOUL OF OUR MECHANISM
        //I thINK
        throw;
    }

    function getShared(bytes32 id) public returns (uint data_shared) {
        return (accounts[id].data_shared);
    }

    function getReceived(bytes32 id) public returns (uint data_received) {
        return (accounts[id].data_received);
    }

    function getScienceIndex(bytes32 id) public returns (uint science_index) {
        return (accounts[id].science_index);
    }











}