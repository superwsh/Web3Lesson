// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// Create2可以计算出即将部署的合约地址。
contract DeployWithCreate2 {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }
}

contract Create2Factory {
    event Deploy(address indexed addr);

    function create(uint _salt) external {
        DeployWithCreate2 deploy = new DeployWithCreate2{
            salt: bytes32(_salt)
        }(msg.sender);

        emit Deploy(address(deploy));
    }

    //create2的底层实现
    function getAddress(bytes memory bytecode, uint salt) external view returns(address) {
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff), address(this), salt, keccak256(bytecode)
        ));
        //hash是32字节--256位，address是20字节--160位。将hash解析为160位再转为地址
        return address(uint160(uint256(hash)));
    }

    function getByteCode(address owner) external pure returns(bytes memory) {
        //type() 是 Solidity 内置元类型函数，专门获取合约编译元信息
        //creationCode：返回合约的字节码（部署字节码）
        bytes memory bytecode= type(DeployWithCreate2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(owner));
    }
}