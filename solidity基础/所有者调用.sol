// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract MyOwnable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "invalid address");
        owner = newOwner;
    }

    function onlyOwnerCallThisFunc() external onlyOwner {
        //code
    }

    function anyoneCallThisFunc() external {
        //code
    }
}