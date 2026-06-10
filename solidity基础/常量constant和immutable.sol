// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 常量可以节省gas
// constant：必须在声明时赋值，不能使用运行时值‌（如 msg.sender、block.timestamp）
// immutable：可以在构造函数中赋值一次，允许运行时值‌（如msg.sender、block.number）
contract Constant {
    // 作业内容
    // 1. 编写一个Solidity合约，包含以下要求：
    // ◦ 定义一个名为 owner 的状态变量，并使用 immutable 关键字。
    // ◦ 在合约的构造函数中将 owner 初始化为 msg.sender 。
    // ◦ 编写一个函数 getOwner ，返回 owner 的值。
    // 2. 编译并部署合约。
    // 3. 调用 getOwner 函数，验证合约部署时 owner 的值正确性。
    address public constant MY_ADDR = 0xf8e81D47203A594245E36C48e151709F0C19fBe8;//373 gas
    uint public constant MY_UINT = 123;

    address public immutable owner;

    constructor(){
        owner = msg.sender;
    }

    function getOwner() public view returns (address){
        return owner;
    }
}