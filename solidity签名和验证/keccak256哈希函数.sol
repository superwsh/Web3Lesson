// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Keccak256的常见用例：签名、生成唯一ID、防止抢跑（Commit-Reveal机制）
// abi.encode 和 abi.encodePacked 的区别： 
// abi.encode 保留更多信息，abi.encodePacked 压缩数据
// 避免哈希冲突：通过添加一个额外的整数参数，改变输入顺序，避免哈希冲突


// 创建一个名为 MyHash 的合约，其中包含以下功能：
// ◦ 函数 hashFunction ：接受字符串 text 、整数 num 和地址 addr 作为参数，返回这些参数的Keccak256哈希值。
// ◦ 函数 encodeFunction ：接受两个字符串 text0 和 text1 ，使用abi.encode 编码并返回结果。
// ◦ 函数 encodePackedFunction ：接受两个字符串 text0 和 text1 ，使用abi.encodePacked 编码并返回结果。
// ◦ 函数 collisionFunction ：接受两个字符串 text0 和 text1 ，使用abi.encodePacked 编码并返回Keccak256哈希值。
contract MyHash {
    function hashFunction(string memory text,uint num,address addr) external pure returns(bytes32){
       return keccak256(abi.encodePacked(text,num,addr));
    }

    function encodeFunction(string memory text0,string memory text1) external pure returns(bytes memory) {
        return abi.encode(text0, text1);
    }

    function encodePackedFunction(string memory text0,string memory text1) external pure returns(bytes memory){
        return abi.encodePacked(text0,text1);
    }

    function collisionFunction(string memory text0,uint num,string memory text1) external pure returns(bytes memory){
        return abi.encodePacked(text0, num, text1);
    }
}