// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// • Fallback函数的执行条件
// ◦ 当调用的函数不存在且 msg.data 不为空时执行
// • Receive函数的执行条件
// ◦ 当 msg.data 为空时执行
contract Fallback {
    // 作业内容：编写一个包含Fallback和Receive函数的Solidity合约，并测试其行为。
    // 要求：
    // 1. 定义一个可以接收Ether的合约，包含Fallback和Receive函数。
    // 2. Fallback函数应记录调用者地址、发送的金额和数据。
    // 3. Receive函数应记录调用者地址和发送的金额。
    // 4. 部署合约并测试：
    // ◦ 发送带数据的Ether，验证Fallback函数被调用。
    // ◦ 发送不带数据的Ether，验证Receive函数被调用。
    // ◦ 删除Receive函数，再次发送不带数据的Ether，验证Fallback函数被调用。

    event Log(string func,address sender,uint amount,bytes data);

    fallback() external payable { 
        emit Log("fallback",msg.sender, msg.value, msg.data);
    }

    receive() external payable {
        emit Log("receive",msg.sender, msg.value, "");
    }
}