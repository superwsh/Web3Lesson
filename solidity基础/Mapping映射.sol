// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract MappingContract {
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


    // • 要求：
    //     a. 使用Solidity 0.8编写合约。
    //     b. 实现一个 set 函数，用于向 balances 添加或更新条目，并处理 keys 和 inserted 。
    //     c. 实现 getSize 函数返回当前 keys 数组的长度。
    //     d. 实现函数，根据传入的索引返回相应地址的余额。
    // • 测试：
    //     a. 向合约中添加几个不同的地址和余额。
    //     b. 调用获取大小的函数确保大小正确。
    //     c. 分别尝试获取第一个和最后一个元素的余额，确保返回正确。
    address[] public keys;
    mapping(address => bool) public inserted;

    function set(address addr, uint amount) public {
        balances[addr] = amount;
        if(!inserted[addr]) {
            keys.push(addr);
            inserted[addr] = true;
        }
    }

    function getSize() public view returns(uint){
        return keys.length;
    }

    function getAmount(address addr) public view returns(uint){
        return balances[addr];
    }

    function first() external  view returns(uint){
        return balances[keys[0]];
    }

     function last() external  view returns(uint){
        return balances[keys[keys.length - 1]];
    }
}