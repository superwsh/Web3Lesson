// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract DataLocation {
    // ◦ storage：状态变量，可修改
    // ◦ memory：临时存储，不保存在区块链上，可读写
    // ◦ calldata：函数输入，不可修改，可用于节省 gas


    // • 定义一个struct，包含一个字符串和一个整数数组。
    // • 实现两个函数：
    // a. 一个函数用于修改struct的字符串成员，该函数的参数为字符串，使用storage存储数据位置。
    // b. 另一个函数用于读取struct的整数数组成员，该函数的参数为整数数组，使用calldata存储数据
    // 位置，且在函数内部调用时，参数也使用calldata存储位置。
    struct MyStruct {
        string text;
        uint arr;
    }

    mapping(address => MyStruct) map;

    function modify(string memory) external {
        map[msg.sender] = MyStruct({text: "123", arr:123});

        MyStruct storage myStruct = map[msg.sender];
        myStruct.text = "hello";
    }   

    function example(uint[] calldata arr) external returns(uint[] memory) {
        _internal(arr);
        uint[] memory newArr = new uint[](3);
        newArr[1] = 888;
        return newArr;
    }

    function _internal(uint[] calldata arr) private returns(uint) {
        // uint x = arr[0];
    }
}



// 创建一个Solidity智能合约，名为 MessageStore ，包含以下功能：
// • 一个公开的状态变量 message 用于存储一个字符串。
// • 一个 setMessage 函数，允许用户输入一个字符串并将其存储到 message 状态变量中。该函数 应使用calldata数据位置。
// • 一个 getMessage 函数，返回 message 状态变量的内容。该函数应声明为external，并使用 memory数据位置。
contract MessageStore {
    string public message;

    function setMessage(string calldata newMsg) external {
        message = newMsg;
    }

    function getMessage() external view returns(string memory){
        return message;
    }
}