contract Accounts {

    address owner;

    modifier owneronly { if (msg.sender == owner) _;}

    function setOwner(address addr) internal owneronly {
        owner = addr;
    }

    struct Account {
        bytes32 user_id;
        address user_addr;
        uint data_shared_unused;
        uint data_shared_used;
        uint[] papersusingdata_citations; //might map paper ids to citation counts
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
        require(addr_to_id[msg.sender] == 0);
        Account memory acc;
        acc.user_addr = msg.sender;
        acc.user_id = keccak256(acc.user_addr);
        bindEthereumAddress(acc.user_addr, acc.user_id);
        acc.data_shared_unused = 0;
        acc.data_shared_used = 0;
        acc.data_received = 0;
        acc.science_index = 0;
    }

    function shareData(bytes32 id) private {
        accounts[id].data_shared_unused += 1;
    }

    function receiveData(bytes32 id) private {
        accounts[id].data_received += 1;
    }

    //function updatePapers(bytes_32 id, bytes_32 paper_id) {
    //  accounts[id].papersusingdata_citations[paper_id]++;
    //}

    function updateScienceIndex(bytes32 id) private {
        //sort papersusingdata_citations array backwards
        //uint count = 0;
        //for citation_count in papersusingdata_citations
        //      if citation_count < count:
        //          break;
        //      count++;
        //accounts[id].science_index = count
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