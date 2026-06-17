// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;


contract Bitwise {
    // x = 1110 = 8 + 4 + 2 + 0 = 14
    // y = 1011 = 8 + 0 + 2 + 1 = 11
    // x & y = 1010 = 8 + 0 + 2 + 0 = 10
    function and(uint x,uint y) public pure returns(uint) {
        return x & y;
    }

    // x = 1100 = 8 + 4 + 0 + 0 = 12
    // y = 1001 = 8 + 0 + 0 + 1 = 9
    // x & y = 1101 = 8 + 4 + 0 + 1 = 13
    function or(uint x,uint y) public pure returns(uint) {
        return x | y;
    }

    // x = 1100 = 8 + 4 + 0 + 0 = 12
    // y = 1001 = 8 + 0 + 0 + 1 = 9
    // x ^ y = 0101 = 0 + 0 + 4 + 4 = 5
    function xor(uint x,uint y) public pure returns(uint) {
        return x ^ y;
    }

    // x = 00001100 = 8 + 4 + 0 + 0 = 12
    // ~x = 11111011 = 128 + 64 + 32 + 16 + 0 + 0 + 2 + 1 = 243
    function not(uint8 x) public pure returns(uint) {
        return ~x;
    }

    // x = 0011 = 0 + 0 + 2 + 1 = 3
    // x << 1 = 0110 = 0 + 4 + 2 + 0 = 6
    function shiftLeft(uint x,uint n) public pure returns(uint) {
        return x << n;
    }

    // x = 1100 = 8 + 4 + 0 + 0 = 12
    // x >> 2 = 0011 = 0 + 0 + 2 + 1 = 3
    function shiftRight(uint x,uint n) public pure returns(uint) {
        return x >> n;
    }

    // • 任务：实现函数 getLastNBits(uint x, uint n) ，该函数返回数字 x 的最后 n 个二进制位。
    // • 示例：如果 x = 13 (二进制1101) 且 n = 3 ，函数应返回 5 (二进制101) 。
    // x = 19 = 1101 
    // mask = (0001 << 3 )- 1 = 0111
    // x & mask = 0101
    function getLastNBits(uint x, uint n) public pure returns(uint) {
        uint mask = (1 << n) - 1;
        return x & mask;
    }
}