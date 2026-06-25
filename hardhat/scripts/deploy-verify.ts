import { ethers } from "hardhat";

async function deploy() {
    const contract = await ethers.getContractFactory("Verify");
    const verify = await contract.deploy();
    await verify.waitForDeployment();
    console.log("contract address is ", await verify.getAddress())
}


deploy();