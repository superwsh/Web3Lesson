// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract array{
    uint[] public nums = [1, 2, 3];
    uint[3] public fixedNums = [4, 5, 6];
    uint[] public numArr = [1,2,3];

    function example() public {
        nums.push(4);// [1,2,3,4]
        nums[2] = 888;// [1,2,888,4]
        delete nums[1];// [1,0,888,4]
        nums.pop();// [1,0,888]

        uint[] memory arr = new uint[](5) ;// 临时创建数组
        arr[1] = 22;
    }
    
    function getLength() public view returns (uint){
        return nums.length;
    }

     // 通过平移算法删除数组中的元素（效率低，消耗gas多）
    function removeEle(uint[] memory newArr, uint index) public returns (uint[] memory){
        require(index < newArr.length, "index out of bound");
        numArr = newArr;
        for (uint i = index;i < numArr.length - 1;i++) {
            numArr[i]= numArr[i+1];
        }
        numArr.pop();
        return numArr;
    }
}