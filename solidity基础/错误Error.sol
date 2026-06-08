// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ErrorHandle{
    function testRequire(uint number) public pure {
        require(number < 10,"It's > 10");
    }

    function testRevert(uint _n) public pure {
        if(_n > 10){
            revert("It's > 10");
        }
    }

    //自定义error可以节省gas
    //自定义的error要配合revert关键字使用
    error MyError(address caller,uint i);

    function testMyError(uint i) public view{
        if(i > 10){
            revert MyError(msg.sender, i);
        }
    }
}