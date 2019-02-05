pragma solidity ^0.4.24;

contract Container {

    uint256 _id;
    bool    _doorsOpen = false;
    bool    _movement = false;
    address _owner;

    event DoorsOpened();
    event DoorsClosed();

    constructor(uint256 id) public {
        _id = id;
        _owner = tx.origin; // Do not use tx.origin in production code: https://github.com/ethereum/solidity/issues/683
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
        if (doorsOpen) {
            emit DoorsOpened();
        } else {
            emit DoorsClosed();
        }
    }

    function movementDetected() public onlyOwner {
        _movement = true;
    }

    function hasMovementBeenDetected() public view returns (bool movementDetected) {
        return _movement;
    }
}