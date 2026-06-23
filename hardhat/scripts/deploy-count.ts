import { ethers } from "hardhat";

async function deploy() {
    const contract = await ethers.getContractFactory("Counter");
    const counter = await contract.deploy();
    await counter.waitForDeployment();
    console.log("contract address is ",await counter.getAddress())
    return counter;
}

async function count(counter: any) {
    await counter.inc();
    console.log("count is ", await counter.getCount());
}

deploy().then(count);