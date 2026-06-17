// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;


// 实现另一个函数 callWithKeyValue ，该函数使用键值对调用 sumFunc 函数，传入任意顺序的参数，并返回一些结果。
contract KeyValueFuntion {
    function sumFunc(uint x, uint y, uint z, address a, bool b, string memory c) internal pure {

    }

    function callWithKeyValue() public pure {
        sumFunc({
            x: 3,
            z: 2,
            y: 6,
            b: true,
            a: address(0),
            c: "123"
        });
    }
}