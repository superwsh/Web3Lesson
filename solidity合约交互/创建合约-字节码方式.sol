// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// EVM（以太坊虚拟机） 就像一个全球共用的"超级计算机"，但它只会做最简单的几件事（加、减、存、取、跳转等）。这些操作指令就是字节码。
// Solidity 写的高级代码，编译器最终会翻译成这种字节码，EVM 才能执行。
contract Factory {
    event Log(address addr);
    function deploy() external {
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        address addr;
        //  create 操作码
        // 作用：创建一个新的合约实例。
        // 参数：create(v, p, n)
        // v：发送的 Wei 数量（这里是 0，即不转账 ETH）。
        // p：指向内存中合约字节码起始位置的指针。
        // n：要复制的字节码长度。
        assembly {
            addr := create(0,add(bytecode,0x20), 0x13)
            
        }
        require(addr != address(0), "deploy failed");
        emit Log(addr);
    }   
}

/*
--------------部署阶段，创建时代码（Creation Code）① 把"返回42"这段代码放进内存 ② 告诉EVM：取这10字节，刻成新合约   
【将运行时代码存入内存】
PUSH10 0x602a60005260206000f3 → 69602a...f3
PUSH1 0 → 6000
MSTORE → 52
【EVM 的内存每个格子是 32 字节，那个 10 字节的运行时代码被塞在最右边。】
0x00000000000000000000000000000000000000000000602a60005260206000f3
【从第22字节开始取10个字节的内容】
PUSH1 0x0a → 600a
PUSH1 0x16 → 6016
RETURN → f3
【完整字节码】
69602a60005260206000f3600052600a6016f3
--------------调用阶段，运行时代码（Runtime Code）① 把42写进内存 ② 返回32字节的42   
【生成表示42的字节码】
42的16进制表示压入栈：PUSH1 0x2a → 602a     EVM中PUSHn=0x5f+n
内存的第0个位置压入栈：PUSH1 0 → 6000
弹出两个值：MSTORE → 52
内存[0] = 42
【生成表示返回32字节的字节码】
32进制的16进制表示压入栈：PUSH1 0x20 → 6020
0的16进制表示压入栈：PUSH1 0 → 6000
从第0字节开始取32字节返回：RETURN → f3
【返回42的字节码表示】
602a60005260206000f3
*/