// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FunctionModifier {
    uint private number;
    modifier nonZero {
        require(number != 0, "Number is zero");
        _;
    }

    function doubleNuamber() public nonZero{
        number *= 2;
    }

    function resetNumber() public{
        number = 0;
    }
}