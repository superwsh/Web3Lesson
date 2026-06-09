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
    storage  链上永久存储
    memory   内存临时存储
    calldata 存外部只读数据
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