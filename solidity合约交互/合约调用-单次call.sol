// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 1. 创建一个名为 TestContract 的合约，包含以下函数：
// ◦ foo(string memory _msg, uint256 _num) : 接受字符串和uint256类型参数，并更新状态变量 message 和 number 。
// ◦ fallback() external : 回退函数，记录日志"Fallback was called"。
// 2. 创建一个名为 Caller 的合约，包含以下函数：
// ◦ callFoo(address _testContract, string memory _msg, uint256 _num) :
// 使用call调用 TestContract 合约中的 foo 函数，并传递参数和发送以太币。
// ◦ callNonExistentFunction(address _testContract) : 使用call调用一个不存在的函数，验证回退函数是否被调用。

contract TestContract {
    string  public  message;
    uint256 public number;
    event Log(address sender,string message);

    function foo(string memory _msg,uint256 num) external payable returns(bool, uint) {
        message = _msg;
        number = num;
        return (true, 888);
    }

    receive() external payable { }
    // fallback() external payable { 
    //     emit Log(msg.sender, "Fallback was called");
    // }
}


contract Caller {
    bytes public data;
    function callFoo(address testAddr,string memory message,uint256 num) public payable {
       (bool success,bytes memory _data) = testAddr.call{value: 123}(abi.encodeWithSignature("foo(string,uint256)", message,num));
        require(success, "Call failed");
        data = _data;
    }

    function callNonExistentFunction(address testAddr) public  {
        (bool success,) = testAddr.call(abi.encodeWithSignature("noExist()"));
        require(success, "Call Failed");
    }

    //encodeCall严格检查，确保函数名和参数正确。
    function encodeCall(address to, uint256 amount) public pure returns (bytes memory) {
        return abi.encodeCall(IERC20.transfer, (to,amount));
    }
}

interface IERC20 {
    function transfer(address to, uint256 amount) external pure returns (bool);
}
