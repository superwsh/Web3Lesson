// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 编写一个智能合约，包含以下功能：
// 1. 合约初始化和调用
// ◦ 创建一个合约 MyCallerContract ，用于调用目标合约 MyTargetContract 。
// ◦ 在 MyCallerContract 中编写一个函数 setTargetX ，调用 MyTargetContract的 setX 函数，并传递参数。
// 2. 直接调用
// ◦ 在 MyCallerContract 中编写一个函数 getTargetX ，直接调用MyTargetContract 的 getX 函数，并返回结果。
// 3. 传递Ether
// ◦ 在 MyCallerContract 中编写一个函数 setXWithEther ，调用MyTargetContract 的 setXAndReceiveEther 函数，并传递Ether值。
// 4. 处理多个返回值
// ◦ 在 MyCallerContract 中编写一个函数 getXAndValueFromTarget ，调用MyTargetContract 的 getXAndValue 函数，并返回多个输出值。
contract CallerContract {
    function setTargetX(address targetAddr,uint value) public {
        TargetContract(targetAddr).setX(value);
    }

    function getTargetX(TargetContract target) public view  returns(uint) {
       return target.getX();
    }

    function setXWithEther(TargetContract target,uint value,uint amount) external payable {
        target.setXAndReceiveEther(value,amount);
    }

    function getXAndValueFromTarget(TargetContract target) external view returns(uint value ,uint amount)  {
        (value,amount) = target.getXAndValue();
    
    }
}

contract TargetContract {
    uint public value;
    uint public amount;
    function setX(uint newValue) external {
        value = newValue;
    }

     function getX() external view returns(uint x) {
        return value;
    }

    function setXAndReceiveEther(uint newValue,uint newAmount) external payable {
        value = newValue;
        amount = newAmount;
    }

    function getXAndValue() external view returns(uint,uint){
        return (value,amount);
    }
}