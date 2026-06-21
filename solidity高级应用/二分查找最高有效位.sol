// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// 任务：编写一个Solidity函数，使用二分查找法找出 uint256 类型数字的最高有效位。
// • 要求
// ◦ 定义函数 findMostSignificantBit(uint256 x) returns (uint8 r) 。
// ◦ 使用二分查找法，按步骤检查 x 是否大于或等于 2^n （n为128，64，32等），并根据条件
// 判断适当地右移 x 并更新 r 。
// • 测试
// ◦ 输入数值8，验证返回结果是否为3。
// ◦ 输入数值9，验证返回结果是否为3。
// ◦ 输入数值15，验证返回结果是否为3。
contract MostSignificantBit {
    function findMostSignificantBit(uint256 x) public pure returns (uint8 r) {
        if(x >= 2 ** 128) {
            x >>=128;
            r += 128;
        }
        if(x >= 2 ** 64) {
             x >>=64;
            r += 64;
        }
        if(x >= 2 ** 32) {
             x >>=32;
            r += 32;
        }
        if(x >= 2 ** 16) {
             x >>=16;
            r += 16;
        }
        
        if(x >= 2 ** 8) {
             x >>=8;
            r += 8;
        }
        // 00001
        if(x >= 2 ** 4) {
             x >>=4;
            r += 4;
        }
        // 1001
        if(x >= 2 ** 2) {
             x >>=2;
            r += 2;
        } 
        if(x >= 2) {
            r += 1;
        }
    }

    //汇编语言，可以节省gas
    function findMostSignificantBitAssembly(uint256 x) public pure returns (uint8 r) {
        assembly {
            let f := shl(7, gt(x,0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)) 
            x := shr(f, x)
            r := or(r, f)
        }

        assembly {
            let f := shl(6, gt(x,0xFFFFFFFFFFFFFFFF)) 
             x := shr(f, x)
            r := or(r, f)
        }

        assembly {
            let f := shl(5, gt(x,0xFFFFFFFF)) 
             x := shr(f, x)
            r := or(r, f)
        }

        assembly {
            let f := shl(4, gt(x,0xFFFF)) 
             x := shr(f, x)
            r := or(r, f)
        }
        
        assembly {
            let f := shl(3, gt(x,0xFF)) // 如果x>255，返回1左移3位，f=8;如果x<255，返回0左移2位，f=0
             x := shr(f, x)
            r := or(r, f)
        }

        assembly {
            let f := shl(2, gt(x,0xF)) // 如果x>15，返回1左移2位，f=4;如果x<15，返回0左移2位，f=0
             x := shr(f, x)
            r := or(r, f)
        }
        
        assembly {
            let f := shl(1, gt(x,0x3)) // 如果x>3，返回1左移1位，f=2;如果x<3，返回0左移1位，f=0
            x := shr(f, x)
            r := or(r, f)
        }
        // 【为什么可以使用or代替累加】
        // 8：1000
        // 4：0100
        // 或运算得1100 = 8+4
        // 2：0010
        // 或运算得1110 = 8+4+2
        // 1：0001
        // 或运算得1111 = 8+4+2+1
        // 而如果是0参与或运算，对原结果不会产生任何影响
        assembly {
            let f := gt(x, 0x1)
            r := or(r, f)
        }
    }
}