// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 1. 创建一个名为 MathLib 的Library，包含一个 min 函数，用于返回两个 uint 类型整数中的较小值。
// 2. 创建一个名为 ArrayUtils 的Library，包含一个 sum 函数，用于计算并返回 uint 类型数组中所有元素的和。
// 3. 在测试合约中使用这两个Library，验证其功能。
library MathLib {
    function min(uint x,uint y) internal pure returns(uint) {
        return x < y ? x:y;
    }
}

library ArrayUtils {
    function sum(uint[] storage arr) internal view returns(uint) {
        uint total;
        for (uint i=0; i < arr.length ;i++){
            total += arr[i];
        }
        return total;
    }
}

contract TestLibrary {
    using ArrayUtils for uint[]; // 数据类型增强，表名uint数组可以直接使用ArrayUtils的函数
    uint[] public arr = [1,2,3];

    function testMin() public pure returns (uint){
        return MathLib.min(8,5);
    }

    function testSum()  public view returns (uint){
        // return ArrayUtils.sum(arr);
        return arr.sum(); // 和上面一样
    }
}