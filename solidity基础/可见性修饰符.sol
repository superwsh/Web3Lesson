// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// private：只能在合约内部调用
// internal：合约内部或子合约调用
// external：外部合约调用
// public：所有合约可以调用
contract Base{
    // 任务：编写一个Solidity合约，包含所有四种可见性的函数和状态变量，并验证它们的访问权限。
    uint private priVar;
    uint internal inVar;
    uint public pubVar; 

    function priFunc() private pure returns(string memory){
        return "priFunc";
    }

    function inFunc() internal  pure returns(string memory){
        return "inFunc";
    }

    function exFunc() external  pure returns(string memory){
        return "exFunc";
    }

    function pubFunc() public  pure returns(string memory){
        return "pubFunc";
    }

    function example() public view {
        priVar + inVar + pubVar;
        priFunc();
        inFunc();
        pubFunc();
    }
}

contract Child is Base {
    function example2() public view {
        inVar + pubVar;
        inFunc();
        pubFunc();
    }
}