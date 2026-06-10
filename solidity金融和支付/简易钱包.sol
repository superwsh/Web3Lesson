// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


// 编写一个简单的以太坊智能合约 EtherWallet，要求如下：
//     1. 合约可以接收以太币。
//     2. 只有合约所有者可以提取以太币。
//     3. 合约中有一个函数可以返回当前存储的以太币余额。
contract Wallet {
    address payable public owner;

    constructor() payable {
        owner = payable (msg.sender);
    }

    receive() external payable { }

    function withdraw(uint amount)  external  returns(bool){
        require(msg.sender == owner,"Caller is not owner");
        (bool success,) = msg.sender.call{value: amount}("");
        // payable (msg.sender).transfer(amount);
        return success;
    }   

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
}