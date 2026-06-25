import { Contract } from "ethers";
import { ethers } from "hardhat";

describe("Test Gas", () => {
    it("test gas", async function () {
        const contract = await ethers.getContractFactory("TestGas");
        const tg = await contract.deploy();
        await tg.waitForDeployment();
        await tg.test1();

        for (let i = 0; i < 10; ++i) {
            await tg.test1();
            await tg.test2();
            await tg.test3();
            await tg.test4();
            await tg.test5();
        }
    })
})