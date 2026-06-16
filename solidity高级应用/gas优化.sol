// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;


// gas优化技巧
// • 使用calldata代替memory：通过改变变量存储位置来减少gas消耗。
// • 循环内部变量优化：在循环开始前将状态变量加载到内存，循环结束后再更新状态变量。
// • 表达式短路（Short Circuiting）：优化条件判断逻辑，避免不必要的计算。
// • 循环增量简化：使用 ++i 代替 i + 1 来减少操作。
// • 缓存数组长度：将数组长度存储在局部变量中，减少每次循环的计算量。
// • 数组元素加载到内存：将频繁访问的数组元素预先加载到变量中。
contract OptimizeGas {
    uint public total;
    function optimizeGasUsage(uint[] calldata arr) external {
        uint _total = total;
        for (uint i; i <arr.length;++i) {
            uint num = arr[i];
            if(num %2 == 0 && num < 100) {
                _total += num;
            }
        }
        total = _total;
    }
}