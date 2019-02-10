pragma solidity ^0.4.24;

contract DummyContainer {

    uint256 _id;
    bool    _doorsOpen;
    address _owner;

    event DoorsOpened();
    event DoorsClosed();
	
    constructor() {
        _id = 666;
        _doorsOpen = false;
        _owner = tx.origin;
    }

    modifier onlyOwner() {
        require(tx.origin == _owner); // Do not use tx.origin in production code: https://github.com/ethereum/solidity/issues/683
        _;
    }

    function getId() public view returns (uint256 id) {
        return _id;
    }

    function areDoorsOpen() public view returns (bool doorsOpen) {
        return _doorsOpen;
    }

    function setDoorsOpen(bool doorsOpen) public onlyOwner {
        _doorsOpen = doorsOpen;
        if (_doorsOpen) {
            emit DoorsOpened();
        } else {
            emit DoorsClosed();
        }
    }
}