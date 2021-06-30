App = {
  loading: false,
  contracts: {},

  load: async () => {
    await App.loadWeb3()
    await App.loadAccount()
    await App.loadContract()
    await App.render()
  },

  // https://medium.com/metamask/https-medium-com-metamask-breaking-change-injecting-web3-7722797916a8
  // https://github.com/dappuniversity/eth-todo-list
  loadWeb3: async () => {
    if (typeof web3 !== 'undefined') {
      App.web3Provider = ethereum
      web3 = new Web3(ethereum)
    } else {
      window.alert("Please connect to Metamask.")
    }
    if (window.ethereum) {
      window.web3 = new Web3(ethereum)
      console.log("1")
      try {
        //await ethereum.enable()
        await window.ethereum.request({ method: 'eth_requestAccounts' })
        // Acccounts now exposed
        //web3.eth.sendTransaction({/* ... */})

      } catch (error) {
        console.log("fail")
      }
    }
    else if (window.web3) {
      App.web3Provider = web3.currentProvider
      window.web3 = new Web3(web3.currentProvider)
      // Acccounts always exposed
      //web3.eth.sendTransaction({/* ... */})
    }
    else {
      console.log('Non-Ethereum browser detected. You should consider trying MetaMask!')
    }
  },


  loadAccount: async () => {
    //var accounts = web3.eth.getAccounts()[0];
    //console.log(accounts);
    //App.account = web3.eth.accounts[0]
    //console.log(App.account)
    //await window.ethereum.enable(); 
    //load the metamask account
    var accounts = await window.ethereum.request({ method: 'eth_requestAccounts' }); 
    App.account = accounts[0]; 
  },

  loadContract: async () => {
    const covid19usecase = await $.getJSON('Covid19usecase.json')
    App.contracts.Covid19usecase = TruffleContract(covid19usecase)
    App.contracts.Covid19usecase.setProvider(App.web3Provider)

    // Deploy the smart contract
    App.covid19usecase = await App.contracts.Covid19usecase.deployed()
    console.log("load contract")
  },

  render: async () => {
    if (App.loading) {
      return
    }

    // Update app loading state
    App.setLoading(true)
    //const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' }); 
    //const account = accounts[0]; 
    // Render Account
    console.log(App.account)
    $('#account').html(App.account)
    console.log("success111")
    // Render Tasks
    await App.renderClauses()
    console.log("success")

    // Update loading state
    App.setLoading(false)
  },

  renderClauses: async () => {
    // Load the total clause count from the blockchain
    const clauseCount = await App.covid19usecase.getClauseCount()
    const $clauseTemplate = $('.clauseTemplate')
    //const $uploadTemplate=$('.upload_request')
    
    console.log(clauseCount)

    // Render out each clause with a new clause template
    for (var i = 1; i <= clauseCount; i++) {
      // Fetch the clause data from the blockchain
      const clause = await App.covid19usecase.clauses(i)
      const clauseId = clause[0].toNumber()
      const clauseContent = clause[1]
      const clauseAgree = clause[2]
      App.clauseId=clauseId

      // Create the html for the clause
      const $newClauseTemplate = $clauseTemplate.clone()
      //const $newuploadTemplate = $uploadTemplate.clone()
      //const $newupload=$showupload.clone()
      console.log(clauseId)
      
      $newClauseTemplate.find('.content').html(clauseContent)
      
      const agreeId='agree'+clauseId
      $newClauseTemplate.find('input')
                      .prop('id', agreeId)
                      //.prop('checked', App.submitRequest)
                      //.on('click', App.submitRequest)
      //const requestId='request'+i
      //$newuploadTemplate.find('div').prop('id', requestId)
      const requestId='request'+clauseId
      $newClauseTemplate.find('button')
                      .prop('id', requestId)
      const $showupload=$('#agree1')
      $showupload.on('click', App.requireRequest)
      const $uploadRequest=$('#request1')
      $uploadRequest.on('click', App.submitRequest)

      //$newupload.on('click', App.submitRequest)
      //document.getElementById("1").onclick=submitRequest()
      
      
      // Put the clause in the correct list
      console.log($newClauseTemplate)
      if (clauseAgree) {
        $('#completedClauseList').append($newClauseTemplate)
      } else {
        $('#clauseList').append($newClauseTemplate)
      }

      $newClauseTemplate.show()
    }
  },

  setLoading: (boolean) => {
    App.loading = boolean
    const loader = $('#loader')
    const content = $('#content')
    if (boolean) {
      loader.show()
      content.hide()
    } else {
      loader.hide()
      content.show()
    }
  },

  requireRequest: async () => {
    const showuploadbutton = $('.upload_request').eq(1)
    showuploadbutton.css("display", "block")

  },

  //change state to ReadyforReview
  submitRequest: async () => {
    //web3.eth.defaultAccount = accounts[0]
    //let accounts = await web3.eth.getAccounts()
    //web3.eth.defaultAccount = accounts[0]
    await App.covid19usecase.submitRequest(App.clauseId,{from: App.account})
    //const currentState=App.covid19usecase.getState()
    console.log(App.covid19usecase.getState())
  }

}

$(() => {
  $(window).load(() => {
    App.load()
  })
})
