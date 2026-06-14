// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 1. 创建一个合约 Receiver ，包含一个事件 Log ，用于记录传递的数据。
// 2. 实现一个函数 transfer ，接收一个地址和一个金额，并在调用时触发 Log 事件，记录传递的 message.data 。
// 3. 创建一个合约 FunctionSelector ，实现一个函数 getSelector ，接收一个函数签名字符串，并返回其哈希值的前四字节。
// 4. 部署合约并测试，通过 FunctionSelector 合约验证 Receiver 合约中 transfer 函数的选择器编码是否正确。
contract Receiver {
    event Log(bytes data);

    //0xa9059cbb
    //00000000000000000000000078731d3ca6b7e34ac0f824c42a7cc18a495cabab
    //0000000000000000000000000000000000000000000000000000000000000016
    function transfer(address addr,uint amount) external  {
        emit Log(msg.data);
    }
}

  //传入参数"transfer(address,uint256)"返回结果0xa9059cbb
contract FunctionSelector {
    function getSelector(string calldata funcName) external pure returns(bytes4) {
        return bytes4(keccak256(bytes(funcName)));
    }
}