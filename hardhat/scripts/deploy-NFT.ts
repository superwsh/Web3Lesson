import "@nomicfoundation/hardhat-ethers";

import { ethers } from "hardhat";

async function deploy() {
    const contract = await ethers.getContractFactory("NFT");//获取HelloWorld合约字节码
    const nft = await contract.deploy("MyNFT", "MN");//部署合约
    await nft.waitForDeployment();//等待合约部署完成
    console.log("NFT address is", nft.target);
}


deploy();