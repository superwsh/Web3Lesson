// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// • 作业描述： 创建一个简单的Time Lock合约，包括设置合约所有者、添加 queue 和 execute 函数以处理和执行交易。
// • 目标： 学员需要实现一个能够接受交易，将其放入等待队列，并在满足等待时间后执行的Solidity合约。
// • 基本要求：
// ◦ 实现一个 queue 函数，能够接收目标合约地址、金额（以太）、调用的函数名、数据以及交易可以被执行的时间戳。
// ◦ 添加时间检查，确保传入的时间戳满足最小延迟要求。
// ◦ 创建 execute 函数，用于在等待时间过后执行已队列的交易。
contract TimeLock {
    address public owner;
    mapping(bytes32 => bool) public queued;
    uint public constant MIN_DELAY = 100;
    uint public constant MAX_DELAY = 1000;
    uint public constant GRACE_PERIOD = 1000;

    error AlreadyQueuedError(bytes32 id);
    error NotQueuedError(bytes32 id);
    error TimestampNotInRangeError();
    error AlreadyCancelError(bytes32 id);
    error TimeNotGreaterThanMinError();
    error TimeGreaterThanMaxError();

    event QueueLog(bytes32 indexed  id,address target, uint amount, string  funcName,bytes data, uint timestamp);
    event Cancel(bytes32 id);
    event ExecuteLog(bytes32 indexed  id,address target, uint amount, string  funcName,bytes data, uint timestamp);

    constructor() {
        owner = msg.sender;
    }

    receive() external payable { }

    modifier onlyOwner() {
        require(msg.sender == owner,"not owner");
        _;
    }

    function getId(
          address target, uint amount, string memory funcName,bytes memory data, uint timestamp
    ) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(target, amount, funcName, data, timestamp));
    }

    //入队 
    function queue(
        address target, uint amount, string memory funcName,bytes memory data, uint timestamp
    ) external onlyOwner{
        bytes32 id = getId(target, amount, funcName, data, timestamp);
        if(queued[id]) {
            revert AlreadyQueuedError(id);
        }

        if(timestamp < block.timestamp + MIN_DELAY || timestamp > block.timestamp + MAX_DELAY) {
            revert TimestampNotInRangeError();
        }

        queued[id] = true;

        emit QueueLog(id, target, amount, funcName, data, timestamp);

    }

    //取消入队
    function cancelQueue (bytes32 id) external onlyOwner{
         if(!queued[id]) {
            revert AlreadyCancelError(id);
        }
        queued[id] = false;
        emit Cancel(id);
    }

    //执行
    function execute(
        address target, uint amount, string memory funcName,bytes memory data, uint timestamp
    ) external returns(bytes memory){
         bytes32 id = getId(target, amount, funcName, data, timestamp);
        if(!queued[id]) {
            revert NotQueuedError(id);
        }

        if(timestamp < block.timestamp + MIN_DELAY) {
            revert TimeNotGreaterThanMinError();
        }

        if(timestamp > block.timestamp + MAX_DELAY) {
            revert TimeGreaterThanMaxError();
        }
        queued[id] = true;
        bytes memory funcBytes =  abi.encodeWithSignature(funcName);
        // bytes memory funcBytes1 =  abi.encodePacked(bytes4(keccak256(bytes(funcName)))); //上面代码的底层实现
        (bool success,bytes memory result) =  target.call{value: amount}(funcBytes);
        require(success,"call failed");

        emit ExecuteLog(id, target, amount, funcName, data, timestamp);
        return result;
    }
}

contract TestContrat {

    function test() external pure returns(uint){
       return 1;
    }
    function getTimestamp() external view returns(uint){
        return block.timestamp + 100;
    }
}