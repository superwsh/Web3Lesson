// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract Uncheck {
    function add(uint x,uint y) external pure returns(uint) {
        unchecked {
            return x + y ;
        }
    }

    function subtract(uint x,uint y) external pure returns(uint) {
        unchecked {
            return x - y ;
        }
    }

   function sum(uint x,uint y) external pure returns(uint) {
        unchecked {
            uint x3 = x * x * x;
            uint y3 = y * y * y;
            return x3 + y3;
        }
    }
}