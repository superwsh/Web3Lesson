// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 三种发送ETH的方法:
// ◦ transfer 发送2300 gas。
// ▪ 如果发送失败，整个函数会失败。
// ◦ send 发送2300 gas。
// ▪ 返回一个布尔值，指示发送是否成功。
// ◦ call 转发所有gas。
// ▪ 返回两个值：一个布尔值指示调用是否成功，一个数据值。
 contract Sender {
    // 编写一个Solidity智能合约，包含以下功能：
    // 1. 能够接收ETH（使用 receive 函数）。
    // 2. 能够使用 transfer 方法发送ETH。
    // 3. 能够使用 send 方法发送ETH并处理失败情况。
    // 4. 能够使用 call 方法发送ETH并处理返回值。

    
    constructor() payable {} // 部署合约时接受以太币

    function transferEth(address payable  to, uint amount) external {
        to.transfer(amount);
    }

     function sendEth(address payable  to, uint amount) external {
       bool success =  to.send(amount);
       require(success, "send failed");
    }

    function callEth(address payable to,uint amount) external returns(bool) {
        (bool success, ) = to.call{value: amount}("");
        require(success, "Call failed");
        return success;

    }
}

contract Receiver {
    event Log(uint amount, uint gas);

    receive() external payable { 
        emit Log(msg.value,gasleft());
    }
}