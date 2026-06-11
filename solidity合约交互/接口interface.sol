// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 请学员编写一个合约，该合约通过接口调用另一个已部署的计数器合约，实现以下功能：
// 1. 定义接口 ICounter ，包含以下函数：
// ◦ function getCount() external view returns (uint);
// ◦ function increment() external;
// 2. 编写合约 CallCounter ，包含以下功能：
// ◦ 定义状态变量 uint public count;
// ◦ 定义函数 incrementCounter 调用 ICounter.increment 函数
// ◦ 定义函数 getCount 调用 ICounter.getCount 函数，并返回 count
// 3. 部署 CallCounter 合约后，通过传入已部署的计数器合约地址，调用 incrementCounter和 getCount 函数，实现计数器的增加和获取当前计数值的功能。
interface ICounnter {
    function getCount() external view returns (uint);
    function increment() external ;
}

contract CallCounter {

    function incrementCounter(address counter) public{
        ICounnter(counter).increment();
    }

    function getCount(address counter) public view returns (uint){
       return ICounnter(counter).getCount();
    }

}

contract IcounterImpl {
    uint public count;
    function getCount() external view returns (uint) {
        return count;
    }
    function increment() external {
        count += 1;
    }
}