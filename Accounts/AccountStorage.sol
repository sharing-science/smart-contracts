pragma solidity 0.5.17;
import "./Account.sol";

contract Accounts {
    /**
    address owner;

    modifier owneronly { if (msg.sender == owner) _;}

    function setOwner(address addr) internal owneronly {
        owner = addr;
    }
    */

    mapping(address => Account) accounts;

    function createAccount(string memory name) public {
        require (accounts[msg.sender] == Account(0));
        accounts[msg.sender] = new Account(name);
    }
    
    
    function getName() public view returns (string memory) {
        return accounts[msg.sender].getName();
    }
    
    function getShared() public view returns (uint) {
        return accounts[msg.sender].getShared();
    }
    
    function getReceived() public view returns (uint) {
        return accounts[msg.sender].getReceived();
    }
    
    function getScience() public view returns (uint) {
        return accounts[msg.sender].getScience();
    }
    
    function TransactSomeBiomedicalData(address Sharer) public {
        //Assume data receiver is sending the message **and paying gas!!**
        //Reciever is passed, we can reverse this
        
        /**
         * Do some sharing
         * Confirm it somehow
         * assertTrue(Data == *Shared*)
        */
        
        accounts[Sharer].ShareData();
        accounts[msg.sender].ReceiveData();
        
    }
}