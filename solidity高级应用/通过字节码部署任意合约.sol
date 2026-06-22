// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 任务描述：编写⼀个Solidity合约，该合约能够部署⼀个简单的存储合约，并允许存储和检索⼀个数字。
// • 基本要求：
// a. 存储合约：创建⼀个基本的存储合约，包含⼀个能够设置和读取数值的功能。
// b. 部署合约：编写⼀个部署合约，该合约使⽤输⼊的字节码部署存储合约，并提供⼀个函数来调⽤存储合约的设置和读取功能。
// c. 交互测试：在Remix IDE中部署部署合约，使⽤它来部署存储合约，并测试存储和检索功能是否正常⼯作。
contract Contract1 {
    address public  owner = msg.sender;
    function setOwner(address _owner) external {
        require(msg.sender == owner,"not owner");
        owner = _owner;
    }
}

contract Contract2 {
    address public owner = msg.sender;
    uint public value = msg.value;
    uint public x;
    uint public y;


    constructor(uint _x,uint _y) payable {
        x = _x;
        y = _y;
    }
}

contract Proxy {
    event Deploy(address addr);
    receive() external payable { }

    function deploy(bytes memory bytecode) external payable  returns(address addr) {
        assembly {
            addr := create(callvalue(), add(bytecode, 0x20), mload(bytecode))
        }
    }

    function execute(address target,bytes memory data) external payable {
        (bool success,) =  target.call{value:msg.value}(data);
        require(success,"call failed");
    }
}

contract Helper {
    // 获取合约1的创建时字节码
    function getBytecode1() external pure returns(bytes memory) {
        return type(Contract1).creationCode;
    }
    // 获取合约2的创建时字节码
    function getBytecode2(uint x, uint y) external pure returns(bytes memory) {
        bytes memory code = type(Contract2).creationCode;
        return abi.encodePacked(code,abi.encode(x,y));
    }   
    // 获取调用合约1的setOwner函数的字节码
    function getCallData(address _owner) external pure returns(bytes memory) {
        return abi.encodeWithSignature("setOwner(address)", _owner);
    }
}