pragma solidity ^0.4.24;

contract DummyContainer {

    uint256 id;
    bool    doorsOpen;
    address owner;

    event DoorsOpened();
    event DoorsClosed();
	
	constructor DummyContainer() {
		id = 666;
		doorsOpen = false;
		owner = tx.origin;
	}

    modifier onlyOwner() {
        require(tx.origin == owner); // Do not use tx.origin in production code: https://github.com/ethereum/solidity/issues/683
        _;
    }

    function getId() public view returns (uint256 id) {
        return id;
    }

    function areDoorsOpen() public view returns (bool doorsOpen) {
        return doorsOpen;
    }

    function setDoorsOpen(bool doorsOpened) public onlyOwner {
        doorsOpen = doorsOpened;
        if (doorsOpen) {
            emit DoorsOpened();
        } else {
            emit DoorsClosed();
        }
    }
}