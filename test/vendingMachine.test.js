const VendingMachine = artifacts.require("VendingMachine");

contract("VendingMachine", (accounts) => {
    before(async () => {
        instance = await VendingMachine.deployed()
    })
    it('should run fine', async () => {
        let balance = await instance.getVendingMachineBalance()
        assert.equal(balance, 100, "the initial balance should be 100")
    });
})