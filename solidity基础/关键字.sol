// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract HelloWorld {
    uint256 a = 101;
    bytes32 str = "Hello";
    string strVar = "Hello World";
    // internal：当前合约和子合约可调用  external：外部合约和外部账户调用
    // view：只读取变量  pure：纯运算
    // returs() 声明返回值类型
    // private  public
    /*
    storage  永久变量
    memory   临时变量可修改 
    calldata 临时常量不可修改
    */
    function sayHello() public view returns(string memory){
        return strVar;
    }   

    function setHello(string memory newStr) public {
        strVar = newStr;
    }


   function addInfo(string memory helloStr) internal pure returns(string memory) {
    return string.concat(helloStr,"from Wu's contract");
   }
}