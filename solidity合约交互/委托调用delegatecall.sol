// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// delegatecall在另一个合约的上下文中执行代码，最后更新的是自己的状态变量，花费的是自己的eth
// 1. 创建两个合约： Caller 和 Callee 。
// 2. 在 Caller 合约中定义一个状态变量 num 。
// 3. 在 Callee 合约中定义一个函数 setNum ，接收一个 uint 参数并更新 Caller 合约中的num 变量。
// 4. 在 Caller 合约中实现一个函数，通过delegatecall调用 Callee 合约的 setNum 函数。
// 5. 部署并调用这些合约，验证 num 变量的更新情况。
 contract Caller {
    uint public num;
    function setNum(address addr,uint _num)  public {
        // addr.delegatecall(abi.encodeWithSignature("setNum(uint256)", _num));
        (bool success,) = addr.delegatecall(abi.encodeWithSelector(Callee.setNum.selector, _num));// 和上面一样效果
        require(success, "Call Failed");
    }
 }

 contract Callee {
    uint public num;

    function setNum(uint _num)  public {
        num = _num;
    }
 }