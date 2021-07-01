
/**
 * This hopefully encompasses all of the contract functionality
 * Just an example of how to interact with the contract via web3
 * 
 * Now we just need to write a backend
 * 
 * 
 * **In terminal facing the cwd**
 * 
 * $ truffle develop
 * 
 * truffle(develop)> migrate         
 *                                               or if already migrated to reset values   
 * truffle(develop)> migrate --reset  
 * 
 * 
 * **In seperate terminal**
 * 
 * $ node install
 * 
 * $ node index.js
 * 
 */

const Web3 = require('web3');

const bmd = require('./build/contracts/BioMedicalDataToken.json');

const init = async () => {
    const web3 = new Web3('http://localhost:9545');

    const id = await web3.eth.net.getId();
    const network = bmd.networks[id];

    const contract = new web3.eth.Contract(bmd.abi, network.address);

    var assert = require('assert')





    /**
     * to get the total supply of the token
     */    
    const supply_original = await contract.methods.getSupply().call();
    assert(supply_original == 50);
    console.log(supply_original);





    const account1 = '0x9245632820c1269c1974bf3c8d0a02d4454026a5';
    /**
     * Initial owner account is the first truffle account in the develop environment 
     * We can pass balanceOf() the address and receive back that accounts balance
     * 
     * For the owner this will be the initial total supply passed on migration
     * Currently this is 5 BMD or 50 units (1 decimal in the token currently)
     */
    const balanceofowner = await contract.methods.balanceOf(account1).call();
    assert(balanceofowner == 50)
    console.log(balanceofowner);
    
    



    /**
     * Likewise we interact with each function by passing the specific address
     * Not sure how this will play out with lookups
     * 
     * **Reminder**
     * These are all read only so we .call() we do not .send()
     */
    const nameofowner = await contract.methods.getName(account1).call();
    assert(nameofowner == 'Kacy')
    console.log(nameofowner);
    
    const ownershared = await contract.methods.getShared(account1).call();
    assert(ownershared == 0)
    console.log(ownershared);

    const ownerreceived = await contract.methods.getReceived(account1).call();
    assert(ownerreceived == 0)
    console.log(ownerreceived);

    const sci = await contract.methods.getScience(account1).call();
    assert(sci == 0)
    console.log(sci);





    const account2 = '0x8006495558389ed90e657d552315956cb7d59921'
    /**
     * Here we can register a second user using another truffle dev address
     * This will allow us to complete transactions between the two
     * 
     * We can do this simply by passing the name and setting the msg.sender ( {from:account2} )
     * to the address we want to register
     * 
     * Here we .send() and this will cost gas
     */
    await contract.methods.Register('account2').send({from:account2});

    const balanceofnew = await contract.methods.balanceOf(account2).call();
    assert(balanceofnew == 50);
    console.log(balanceofnew);
    
    const nameofnew = await contract.methods.getName(account2).call();
    assert(nameofnew == 'account2');
    console.log(nameofnew);






    /**
     * So now we can do some sharing?
     * The current price is 3 BMD or 30 units and transferBioMedicalData(address sharer, address receiver) handles all of this
     * The function returns true if the transaction is completed
     * 
     * So if both of the current accounts have 5
     * And Kacy shares data with account2
     * Kacy should have 8 BMD and account2 should have 2 BMD
     */
    let result = await contract.methods.transferBioMedicalData(account1, account2).send({from:account1});
    assert(result);
    console.log(result);

    assert(await contract.methods.balanceOf(account1).call() == 80);
    assert(await contract.methods.balanceOf(account2).call() == 20);



}

init();



