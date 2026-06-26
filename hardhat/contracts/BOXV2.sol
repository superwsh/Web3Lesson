// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

contract BOXV2 is Initializable {
    uint public x;

    //initializer代表这个函数只能被执行一次
    function initialize(uint val) external initializer {
        x = val;
    }

    function cal() external {
        x *= 3;
    }
}
