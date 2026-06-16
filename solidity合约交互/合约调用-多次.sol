// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// 任务：使用Solidity编写一个合约，实现multicall合约的功能。 要求：
// • 创建一个名为Multicall的合约。
// • 实现一个名为multicall的函数，接受合约地址和调用数据作为参数。
// • multcall函数应为external view，并返回每个调用的结果。
// • 在multicall函数内部，使用静态调用（static call）方式调用每个目标合约的函数，并将结果存储在字节数组中。
// • 编写测试用例验证Multicall合约的功能。
contract TestMultiCall {
    function func1() external view returns(uint, uint) {
        return (1,block.timestamp);
    }
    function func2() external view returns(uint, uint) {
        return (2,block.timestamp);
    }

    //获取函数func1的字节码
    function getFunc1Byte() external pure returns(bytes memory) {
        // return abi.encodeWithSignature("func1()");
        return abi.encodeWithSelector(this.func1.selector);
    }
     //获取函数func2的字节码
    function getFunc2Byte() external pure returns(bytes memory) {
        // return abi.encodeWithSignature("func2()");
        return abi.encodeWithSelector(this.func2.selector);
    }
}

contract MultiCall {
    function multicall(address[] calldata addrs,bytes[] calldata funcBytes) external view returns(bytes[] memory){
        bytes[] memory results = new bytes[](addrs.length);
        for (uint i = 0;i < addrs.length; i++) {
            (bool success,bytes memory result) = addrs[i].staticcall(funcBytes[i]);
            require(success, "call failed");
            results[i] = result;
        }
        return results;
    }
}