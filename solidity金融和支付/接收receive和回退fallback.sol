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


// 1. 计数器合约
// ◦ 声明一个 count 状态变量
// ◦ 编写一个 inc 函数，每次调用时将 count 加1，并返回 count 的当前值
// 2. 回退输入输出合约
// ◦ 编写一个回退函数，能够接受 bytes 类型的数据并返回 bytes 类型的数据
// ◦ 回退函数内部调用计数器合约的 inc 函数，并返回调用结果
// 3. 测试合约
// ◦ 编写一个测试函数，接受回退合约的地址和数据，调用回退函数，并返回结果
// ◦ 编写一个辅助函数，生成调用计数器合约 inc 函数的数据

contract Counter {
    uint internal count;
    function inc() external returns(uint) {
        count += 1;
        return count;
    }
}

contract FallbackIo {
    address addr;
    constructor(address _addr) {
        addr = _addr;
    }
    fallback(bytes calldata funcBytes) external payable returns(bytes memory) {
         (bool success,bytes memory result) = addr.call(funcBytes);
         require(success, "call failed");
         return result;
    }
}

contract TestContract {
    event Log(bytes res);

    function test(address _fallback,bytes calldata funcBytes ) external {
        (bool success,bytes memory result)  = _fallback.call(funcBytes);
        require(success, "callfailed");
        emit Log(result);
    }

    function getFuncBytes() external pure returns(bytes memory) {
        return abi.encodeWithSignature("inc()");
    }
}

