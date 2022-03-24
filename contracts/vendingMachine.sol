pragma solidity ^0.8.11;

contract VendingMachine {
    address payable public owner;
    mapping (address => uint256) public donutBalance;
    constructor() {
        owner = payable(msg.sender);
        donutBalance[address(this)] = 100;
    }
    function getVendingMachineBalance() public view returns (uint256) {
        return donutBalance[address(this)];
    }
    modifier restriction() {
        require(address(this) != owner, "can only be restock by the owner");
        _;
    }
    function restock(uint amount) public restriction {
       donutBalance[address(this)] += amount;
    }
    modifier purchaseRestriction(uint amount) {
        //ether here is a misery
        require(msg.value >= amount * 2 ether , "you must pay at least 2 ETH per donut");
        require(donutBalance[address(this)] >= amount);
        _;
    }
    function purchase(uint amount) public payable purchaseRestriction(amount) {
        owner.transfer(amount);
    }
}
