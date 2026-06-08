// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract MappingCon {
    // ◦ 创建一个公开的映射 balances ，键类型为 address ，值类型为 uint 。
    // ◦ 实现一个函数 deposit() ，允许用户为自己的账户存款。
    // ◦ 实现一个函数 withdraw(uint amount) ，允许用户从自己的账户中提取金额。
    // ◦ 实现一个函数 checkBalance() ，返回调用者的当前余额

    mapping(address => uint) public balances; 

    function deposit(uint amount) public payable {
        balances[msg.sender] += amount;
    }

    function withdraw(uint amount) public payable  {
        require(balances[msg.sender] >= amount, "Insufficient funds");
        balances[msg.sender] -= amount;
    }

    function checkBalance() public view returns(uint){
        return balances[msg.sender];
    }
}