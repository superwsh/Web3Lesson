// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ToDoList {
    // 编程作业
    // • 任务：编写一个 Solidity 程序，实现一个简单的待办事项列表。
    // • 要求：
    // a. 定义一个 ToDo 结构体，包含 text （任务描述）和 completed （是否完成）。
    // b. 创建一个 ToDo[] 数组来存储多个任务。
    // c. 实现 create , updateText , 和 toggleCompleted 函数。
    // d. 部署合约到测试网络，并通过界面或命令行测试各个函数的功能。
    struct ToDo {
        string text;
        bool completed;
    }

    ToDo[] toDoList;

    function create(string calldata _text) external  {
        toDoList.push(ToDo({
            text: _text,
            completed: false
        }));
    }

    function updateText(uint index, string calldata newText) external {
        toDoList[index].text = newText;

        // ToDo storage todo = toDoList[index];
        // todo.text = newText;  这种方式在更新多个字段时更节省gas
    }

    function toggleCompleted(uint index) external {
        toDoList[index].completed = !toDoList[index].completed;
    }

    function get(uint index) external view returns (ToDo memory){
        return toDoList[index];
    }
}