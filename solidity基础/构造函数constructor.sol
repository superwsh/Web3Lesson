// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Constructor{
    address public owner;
    uint public number;

    //部署合约时调用
    constructor(uint _number){
        owner = msg.sender;
        number = _number;
    } 
}