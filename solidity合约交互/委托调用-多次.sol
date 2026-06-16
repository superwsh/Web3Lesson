// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// 设计一个简单的智能合约，包括以下功能：
// 1. 实现一个名为 MultiDelegateCall 的合约，具有一个外部可支付的函数multiDelegateCall 。
// 2. multiDelegateCall 函数接受一个包含函数调用和参数的字节数据数组，并依次执行这些函数调用。
// 3. 当多重委托调用成功时，返回每个函数调用的结果。
// 4. 针对多重委托调用可能引发的潜在问题，添加适当的注释和错误处理机制。

contract MultiDelegateCall {
    event Log(address caller, string func, uint256 i);

    uint public balance;
    function func1(uint x,uint y) public {
        emit Log(msg.sender,"func1", x+y);
    }
    function func2() public {
        emit Log(msg.sender,"func2",2);
    }

    //WARNING:===这个函数虽然被代理调用多次，但是只支付了一次以太币
    //而这里会计算多次导致引发错误
    function mint() payable public {
        balance += msg.value;
    }

    function multiDelegateCall(bytes[] memory funcBytes) external payable returns(bytes[] memory) {
        bytes[] memory results = new bytes[](funcBytes.length);
        for (uint i; i< funcBytes.length; i++) {
           (bool success,bytes memory result) = address(this).delegatecall(funcBytes[i]);
           require(success,"delegatecall failed");
            results[i] = result;
        }
        return results;
    }
}

contract Helper {
    //获取函数func1的字节码 0x3cb8008500000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002
    function getFunc1Byte(uint x,uint y) external pure returns(bytes memory) {
        return abi.encodeWithSignature("func1(uint256,uint256)",x,y);
    }
     //获取函数func2的字节码 0xb1ade4db
    function getFunc2Byte() external pure returns(bytes memory) {
        return abi.encodeWithSignature("func2()");
    }

    //获取函数func1的字节码 0x1249c58b
    function getMintByte() external pure returns(bytes memory) {
        return abi.encodeWithSignature("mint()");
    }
}