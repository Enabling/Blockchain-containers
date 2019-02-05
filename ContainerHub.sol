pragma solidity ^0.4.24;

import "./Container.sol";

contract ContainerHub {

    mapping(address => uint256[]) containerIds;
    mapping(address => mapping (uint256 => Container)) containers;

    event ContainerCreated(address indexed owner, uint256 indexed id, address containerAddress);

    function createContainer(uint256 id) public {
        Container container = new Container(id);
        containers[msg.sender][id] = container;
        containerIds[msg.sender].push(id);
        emit ContainerCreated(msg.sender, id, container);
    }

    function getMyContainers() public view returns (uint256[] myIds, address[] myAddresses) {
        return getContainersFor(msg.sender);
    }

    function getContainersFor(address owner) public view returns (uint256[] myIds, address[] myAddresses) {
        uint256[] memory ids = containerIds[owner];
        address[] memory addresses = new address[](ids.length);
        for (uint i = 0; i < ids.length; i++) {
            addresses[i] = containers[owner][ids[i]];
        }
        return (ids, addresses);
    }

    function getMyContainer(uint256 id) public view returns (address myContainer) {
        return containers[msg.sender][id];
    }

    function setDoorsOpen(uint256 id, bool doors) public {
        Container(containers[msg.sender][id]).setDoorsOpen(doors);
    }

    function setDoorsOpen(address containerContract, bool doors) public {
        Container(containerContract).setDoorsOpen(doors);
    }

    function areDoorsOpen(uint256 id) public view returns (bool doorsOpen) {
        return Container(containers[msg.sender][id]).areDoorsOpen();
    }

    function areDoorsOpen(address containerContract) public view returns (bool doorsOpen) {
        return Container(containerContract).areDoorsOpen();
    }
}