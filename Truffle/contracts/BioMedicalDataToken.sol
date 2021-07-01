pragma solidity >=0.4.21 <0.7.0;

contract BioMedicalDataToken {

    string public constant name = "BioMedicalData";
    string public constant symbol = "BMD";
    uint8 public constant decimals = 1;

    event NewAccountRegistered(string name, uint256 balance);
    event Transfer(address indexed from, address indexed to, uint tokens);

    struct Account {
        string user_name;
        uint science_index;
        uint data_shared;
        uint data_received;

    }

    mapping(address => uint256) balances;
    mapping(address => Account) accounts;

    uint256 totalSupply;
    using SafeMath for uint256;


    //build token and initial owner/user
    constructor(uint256 total, string memory n) public {  
        totalSupply = total;
        Account memory account = Account(n, 0, 0, 0);
        accounts[msg.sender] = account;
        balances[msg.sender] = total;
        emit NewAccountRegistered(account.user_name, total);
    }  
    
    function Register(string memory n) public {

        Account memory account = Account(n, 0, 0, 0);
        accounts[msg.sender] = account;
        balances[msg.sender] = 50;


        emit NewAccountRegistered(account.user_name, 50);
        totalSupply = totalSupply.add(50);
    }


    //access the stored accounts
    function getSupply() public view returns (uint256) {
        return totalSupply;
    }
    
    function balanceOf(address addr) public view returns (uint256) {
        return balances[addr];
    } 
    
    function getName(address addr) public view returns (string memory) {
        return accounts[addr].user_name;
    }
    
    function getShared(address addr) public view returns (uint) {
        return accounts[addr].data_shared;
    }
    
    function getReceived(address addr) public view returns (uint) {
        return accounts[addr].data_received;
    }
    
    function getScience(address addr) public view returns (uint) {
        return accounts[addr].science_index;
    }
    
    
    //transactions

    /**
    TODO: Error handling in here
     */
    function transferBioMedicalData(address sharer, address receiver) public {
        //do some sharing

        //call to the policy contract and waittttttt
        
        //call (some contract) to get address of confirmations
        //confirm(addr1, add2, addr3, addr4, addr5)
        
        require(30 <= balances[receiver]);
        balances[receiver] = balances[receiver].sub(30);
        balances[sharer] = balances[sharer].add(30);
        emit Transfer(receiver, sharer, 30);
        
        accounts[sharer].data_shared++;
        accounts[receiver].data_received++;
    }
}


//     //this could probably be done within the confirmation contract (yet to come)
//     //We incentivize participation in the network by asking other users to confirm
//     function confirm(address addr1, address addr2, address addr3, address addr4, address addr5) public returns (bool) {
//         balances[addr1] = balances[addr1].add(10);
//         balances[addr2] = balances[addr2].add(10);
//         balances[addr3] = balances[addr3].add(10);
//         balances[addr4] = balances[addr4].add(10);
//         balances[addr5] = balances[addr5].add(10);
//         totalSupply_ = totalSupply_.add(50);
//     }


library SafeMath { 
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
      assert(b <= a);
      return a - b;
    }
    
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
      uint256 c = a + b;
      assert(c >= a);
      return c;
    }
}