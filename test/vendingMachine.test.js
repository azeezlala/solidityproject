const VendingMachine = artifacts.require("VendingMachine");

contract("VendingMachine", (accounts) => {
    before(async () => {
        instance = await VendingMachine.deployed()
    })
    it('should run fine', async () => {
        let balance = await instance.getVendingMachineBalance()
        assert.equal(balance, 100, "the initial balance should be 100")
    });
    it('ensures the balance of the vending machine can be updated', async () => {
        await instance.restock(100)
        let balance = await instance.getVendingMachineBalance()
        assert.equal(balance, 200, "the balance should be 200 after restocking")
    });
    it('allow donut to be purchase', async () => {
        await instance.purchase(1, {from:accounts[0], value: web3.utils.toWei('3', 'ether')});
        assert.equal(balance, 190, 'the balance should be 190')
    })
})