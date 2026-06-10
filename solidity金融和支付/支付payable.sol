// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Payable {
    // 编程作业
    // 1. 定义一个 payable 函数 receiveEther ，用于接收以太币。
    // 2. 创建一个 payable 地址 recipient ，并在构造函数中初始化为 msg.sender 。
    // 3. 编写一个函数 queryBalance ，返回合约当前的以太币余额。
    // 4. 确保在未使用 payable 关键字时，合约无法接收以太币，并记录错误日志。
    address payable public recipient;

    constructor(){
        recipient = payable(msg.sender);
    }

    function receiveEther() external payable  {}

    function queryBalance() external view returns(uint){
        return address(this).balance;
    }

    
}