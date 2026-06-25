import "@nomicfoundation/hardhat-ethers";

import { ethers } from "hardhat";

async function deploy() {
    const HelloWorld = await ethers.getContractFactory("HelloWorld");//获取HelloWorld合约字节码
    const hello = await HelloWorld.deploy();//部署合约
    await hello.waitForDeployment();//等待合约部署完成
    return hello;
}

async function sayHello(hello: any) {
    console.log("Say Hello:", await hello.hello());
}

deploy().then(sayHello);