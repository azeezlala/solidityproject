pragma solidity ^0.8.0;

import "./Mylibrary.sol";

contract ERCToken {
    string public name;
    string public nfturl;
    mapping(address => uint256) public balances;
    function mint() virtual public {
        //use tx.origin instead of msg.sender in this case, bcus tx.origin will take the address of who call contract from another contract
        balances[tx.origin] ++;
    }
    constructor(string memory _nfturl) {
        nfturl = _nfturl;
    }
}

//INHERITING ANOTHER CONTRACT
contract MyToken is ERCToken {
   // string public name = "My token"; // override
    string public symbol ;
    address[] public owners;
    uint256 ownerCount; //to keep track of owners
    constructor(string memory _nfturl, string memory _symbol) ERCToken(_nfturl)  {
        symbol = _symbol;
    }
    function mint() public override {
        super.mint(); //accessing the parent function
        ownerCount ++;
        owners.push(msg.sender);
        //delete owners[msg.sender] //to remove element from array
    }
}
contract learning {
    //Oracle constant oracle = Oracle(0x1234567); //how to communicate with other smart contract
    //payable allows an address to receive payment
    address payable owner;
    mapping(address => uint256) public balances;
    //Event are a way for external consumer to listen to event for another contract
    event Purchase(
        //to subscribe base on specific address
        address indexed _buyer,
        uint256 _amount
    );

    string public value;
    struct Person {
        string _firstName;
        string _lastName;
    }
    Person[] public person;
    uint256 public personCount;
    mapping(uint256 => Person) public people;

    Person public onePerson;
    //address is data, it stores wallet addres
    address public ownerWallet;
    //modifier is like verification
    modifier onlyOwner () {
        //msg can get the address that is interacting with smart contract
        require(msg.sender == ownerWallet);
        _;
    }
    //time stamp is express in seconds
    uint256 openingTime = 1647898833;
    modifier onlyWhileOpen () {
        require(
            block.timestamp >= openingTime);
        _;
    }
    function justTesting() public view onlyWhileOpen returns(string memory) {
        return "just testing";
    }
    function addPerson(string memory _firstname, string memory _lastname) public onlyOwner {
        person.push(Person(_firstname, _lastname));
        //personCount++;
        incrementCount();
        people[personCount] = Person(_firstname, _lastname);
    }
    enum State {Waiting, Ready, Active}
    State public state;
    address payable wallet;
    address public token;
    constructor(address payable _wallet , address _token) public { //this is a constructor
        value = "myValue";
        state = State.Waiting;
        onePerson = Person("lala", "lolo");
        personCount++;
        //to set owner, since the address is the person creating this contract
        owner = payable(msg.sender);
    }
    //payable allow a function to accept payment or transfer ether
    function buyToken(uint256 amount) public payable {
        //buy a token
        ERCToken _token = ERCToken(address(token));
        _token.mint();
        //short hand : ERCToken(address(token)).mint();
        owner.transfer(msg.value);
        uint _senderOriginalAmount = msg.value;
        balances[msg.sender] = _senderOriginalAmount * 1 / 2;
        //send ether to the wallet

        emit Purchase(msg.sender, _senderOriginalAmount);
        //to emit an event
    }
    function activate() public {
        state = State.Active;
    }
    function isActive() public view returns(bool) {
        return state == State.Active;
    }
    //view when a function is not changing anything
    //memory is used when it not writing to the blockchain
    //pure is used when a function calculate
    function get() public view returns(string memory) {
        return value;
    }
    function set(string memory _value) public {
        value = _value;
    }
    function incrementCount() internal {
        personCount++;
    }
    uint256 public calculatedValue;
    function calculate(uint256 _value1, uint256 _value2) public {
        calculatedValue = Mylibrary.divide(_value1, _value2);
    }
    //using SafeMath for uint256 //will use the library on uint256 datatype
}
