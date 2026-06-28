import "@nomicfoundation/hardhat-ethers";

import { ethers } from "hardhat";

async function deploy() {
  const contarct = await ethers.getContractFactory("USDTExample"); //获取合约字节码
  const example = await contarct.deploy(); //部署合约
  await example.waitForDeployment(); //等待合约部署完成
  return example;
}

async function init(example: any) {
  await example.mint("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266", 1000);
  await example.mint("0x70997970C51812dc3A010C7d01b50e0d17dc79C8", 2000);

  console.log("初始成功，totalSupply: ", await example.totalSupply());
}

deploy().then(init);
