// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 请根据课程内容，编写一个基本的多签名钱包合约。要求：
// 1. 定义事件 Deposit 、 Submit 、 Approve 、 Execute 和 Revoke 。
// 2. 定义状态变量 owners 、 isOwner 、 required 、 transactions 和 approve 。
// 3. 编写构造函数，初始化所有者数组和所需批准数。
// 4. 实现 receive 函数接收以太币。
// 5. 编写 submit 函数提交新交易。
// 6. 实现 approve 函数批准交易。
// 7. 编写 execute 函数执行交易。
// 8. 实现 revoke 函数撤销批准。

contract MutiSignWallet {
    event Deposit(address indexed sender, uint amount);// 当以太币存入钱包时触发
    event Submit(uint tsId);
    event Approve(address indexed owner,uint tsId);
    event Exected(address indexed owner,uint tsId);
    event Revoke(uint tsId);

    struct Transaction {
      address to;//交易目标地址、
      uint amount;//金额
      bytes data;//交易数据
      bool exectued;//执行状态
    }

    address[] public owners;//存储所有者地址的数组
    mapping(address => bool) public isOwner;//检查某地址是否为所有者的映射
    uint public required;//执行交易所需的最少批准数
    Transaction[] public transactions;//存储所有交易的数组
    mapping(uint => mapping(address => bool)) public approved;//存储每个交易被每个所有者批准情况的映射

    constructor(uint num) payable {
        address addr1 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
        address addr2 = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
        address addr3 = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
        isOwner[addr1] = true;
        isOwner[addr2] = true;
        isOwner[addr3] = true;
        owners.push(addr1);
        owners.push(addr2);
        owners.push(addr3);
        required = num;
    }

    modifier exists(uint tsId) {
        require(tsId < transactions.length, "invalid tsId");
        _;
    }

    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    modifier notExecuted(uint id) {
        require(!transactions[id].exectued,"alreay execute");
        _;
    }

    modifier isApprovalsGreatTanRequired(uint tsId) {
        uint count;
        for(uint i = 0;i < owners.length; i++) {
            if(approved[tsId][owners[i]]) {
                count += 1;
            }
        }
        require(count >= required , "approvals < required");
        _;
    }

    receive() external payable { 
        emit Deposit(msg.sender, msg.value);
    }

    function submit(address addr,uint _amount,bytes calldata _data) external {
        transactions.push(Transaction({
            to: addr,
            amount: _amount,
            data: _data,
            exectued: false
        }));
    }

    function approve(uint tsId) external exists(tsId) onlyOwner() {
       approved[tsId][msg.sender] = true;
       emit Approve(msg.sender, tsId);
    }

    function execute(uint tsId) external 
        onlyOwner
        exists(tsId)
        notExecuted(tsId) 
        isApprovalsGreatTanRequired(tsId) 
        {
            Transaction storage transaction = transactions[tsId];
            transaction.exectued = true;

            (bool success,) = transaction.to.call{value: transaction.amount}(transaction.data);
            require(success, "execute failed");
            emit Exected(msg.sender,tsId);
        }

    function revoke(uint tsId) external onlyOwner notExecuted(tsId) {
        approved[tsId][msg.sender] = false;
        emit Revoke(tsId);
    }
}