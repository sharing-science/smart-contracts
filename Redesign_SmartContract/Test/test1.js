const Permission_control = artifacts.require('Permission_control');
const Main = artifacts.require('Main');
const Front_end_Control = artifacts.require('Front_end_Control');

require('chai')
  .use(require('chai-as-promised'))
  .should()

contract('Permission_control', ([ContractStates]) => {
  let Permission_control, Main, Front_end_Control

  before(async () => {
    // Load Contracts
    Main_controller = await Main.new()
    Permission_controller = await Permission_control.new(Main_controller.address)
    Front_end_Control = await Front_end_Control.new(Main_controller.address)

    await Permission_controller.acceptClause(1);
 
  })

  describe('Test Accept Clause', async () => {
    it('accept clause 1', async () => {
      const isaccept = await Front_end_Control.getClauseStatus(1);
      assert.equal(isaccept, 1)
    })
  })
})
