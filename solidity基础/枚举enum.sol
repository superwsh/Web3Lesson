// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Enum {
//     • 任务：编写一个Solidity智能合约，实现一个简单的订单处理系统。
//         ◦ 声明一个名为 OrderStatus 的枚举，包括状态： None , Pending , Shipped ,
//         Completed , Rejected , Cancelled 。
//         ◦ 创建一个结构体 Order ，包含买家地址和订单状态。
//         ◦ 实现功能：
//         i. 添加新订单到数组。
//         ii. 更新订单状态。
//         iii. 获取特定订单的状态。
//         iv. 重置订单状态到默认值。
    enum OrderStatus {
        None,
        Pending,
        Shipped,
        Completed,
        Rejected,
        Cancelled
    }

    OrderStatus public status; //默认为None

    struct Order {
        address buyer;
        OrderStatus status;
    }

    Order[] public  orders;

    function add(Order memory order) external {
        orders.push(order);
    }

    function setStatus(OrderStatus newStatus) external {
        status = newStatus;
    }

    function getStatus() external view returns(OrderStatus){
       return status;
    }

    function reset() external {
        delete status;
    }
}