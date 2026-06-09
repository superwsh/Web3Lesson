// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


// 事件的定义和用途
// • 事件在区块链上写入数据。
// • 数据无法被智能合约检索。
// • 事件的主要目的是记录某些事情发生的日志。
// • 作为存储数据的状态变量的廉价替代方案。
contract Event {
    // 使用 index 关键字为事件参数创建索引
    // 通过索引快速搜索事件日志


    // 请按照以下要求编写一个 Solidity 智能合约，完成练习：
    // 1. 声明事件：
    // ◦ 声明一个名为LogMessage的事件，包含以下参数：
    // ▪ 发送者地址（ address ，使用 indexed 关键字）
    // ▪ 接收者地址（ address ，使用 indexed 关键字）
    // ▪ 消息内容（ string ）
    // 2. 创建发送消息的函数：创建一个名为sendMessage的函数，该函数包含两个参数：
    // ▪ 接收者地址（ address ）
    // ▪ 消息内容（ string ）
    // ◦ 在函数内部，使用 emit 记录 LogMessage 事件，将发送者地址设为 msg.sender ，接收者地址设为函数参数，消息内容设为函数参数。
    event LogMessage(address indexed from,address indexed to,string  message);

    function send(address to,string memory text) external {
        emit LogMessage(msg.sender, to, text);
    }
}