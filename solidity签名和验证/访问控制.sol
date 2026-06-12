// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


// 实现一个简化版本的访问控制合约，包含以下功能：
// 1. 定义两个角色： admin 和 user
// 2. 实现分配和撤销角色的函数
// 3. 为合约部署者分配 admin 角色
contract AccessControl {
    event GrantRole(bytes32 indexed role, address indexed account);
    event RevokeRole(bytes32 indexed role, address indexed account);

    mapping(bytes32 => mapping (address => bool)) public roles;
    //0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 public constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    //0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 public constant USER = keccak256(abi.encodePacked("USER"));

    constructor() {
        roles[ADMIN][msg.sender] = true;
    }

    modifier onlyRole(bytes32 role) {
        require(roles[role][msg.sender],"Not Authorized");
        _;
    }

    function grantRole(bytes32 role,address account) external  onlyRole(ADMIN) {
        roles[role][account] = true;
        emit GrantRole(role, account);
    }

    function revokeRole(bytes32 role,address account) external onlyRole(ADMIN) {
        roles[role][account] = false;
        emit RevokeRole(role, account);
    }
}