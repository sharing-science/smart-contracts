

const Web3 = require('web3');

const bmd = require('./build/contracts/BioMedicalDataToken.json');

const init = async () => {
    const web3 = new Web3('http://localhost:9545');

    const id = await web3.eth.net.getId();
    const network = bmd.networks[id];

    const contract = new web3.eth.Contract(bmd.abi, network.address);



    //simple call to totalSupply()
    const supply_original = await contract.methods.totalSupply().call();
    console.log(supply_original);
    
    //call the balance of owner account
    const account1 = '0x9245632820c1269c1974bf3c8d0a02d4454026a5';
    const balanceofowner = await contract.methods.balanceOf(account1).call();
    console.log(balanceofowner);
    
    const nameofowner = await contract.methods.getName(account1).call();
    console.log(nameofowner);

    const ownershared = await contract.methods.getShared(account1).call();
    console.log(ownershared);
    const ownerreceived = await contract.methods.getReceived(account1).call();
    console.log(ownerreceived);
    const sci = await contract.methods.getScience(account1).call();
    console.log(sci);
    
    //register someone new'
    const account2 = '0x8006495558389ed90e657d552315956cb7d59921'
    const accountinstance2 = await contract.methods.Register("account2").send({from:account2}).then(console.log).catch(console.log);
    //const balanceofnew= await contract.methods.balanceOf(account2).call();
    console.log(accountinstance2);
    
    // const nameofnew = await contract.methods.getName(account2).call();
    // console.log(nameofnew);

    //simple call to totalSupply()
    const supply_new = await contract.methods.totalSupply().call();
    console.log(supply_new);
}

init();



