// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract StructContract {
    // 编程作业： 
    // 创建一个Solidity智能合约，包含一个名为 Car 的struct，具有以下属性： make
    // (制造商，字符串类型)， year (生产年份，整数类型)，和 owner (所有者，地址类型)。合约应允许
    // 用户：
    // • 添加新的车辆到数组中。
    // • 访问和修改特定车辆的年份。
    // • 删除车辆记录。
    struct Car{
        string make;
        uint year;
        address owner;
    }

    Car[] public cars;

    function init() external  {
        Car memory toyota = Car("Toyota", 2000, msg.sender);
        cars.push(toyota);
        Car memory bmw = Car({make:"BMW",owner: msg.sender, year:1990});
        cars.push(bmw);
        Car memory tesla;
        tesla.make = "Tesla";
        cars.push(tesla);

        cars.push(Car("xiaomi",2024,msg.sender));

        Car storage car = cars[0];
        car.year = 1999;
        delete car.owner;
    }

    function modify(uint index,uint newYear) external {
        cars[index].year = newYear;
    }

    function addCar(string memory maker,uint year) external {
        Car memory newCar = Car(maker,year,msg.sender);
        cars.push(newCar);
    }

    function delCar(uint index) external {
        delete cars[index];
    } 
}