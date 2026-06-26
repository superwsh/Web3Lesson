import hre, { ethers } from "hardhat";
import "@openzeppelin/hardhat-upgrades";


async function deploy() {
    const BOXV1 = await ethers.getContractFactory("BOXV1");
    const BOXV2 = await ethers.getContractFactory("BOXV2");

    //部署V1代理合约，并调用初始化函数initialize传值1
    const proxy = await hre.upgrades.deployProxy(BOXV1, [1], { initializer: "initialize" });
    await proxy.waitForDeployment();

    console.log("Proxy contract address is ", await proxy.getAddress());
    console.log(await proxy.x());// x为1
    await proxy.cal();
    console.log(await proxy.x())// x为2

    //升级代理合约为V2
    await hre.upgrades.upgradeProxy(await proxy.getAddress(), BOXV2, { unsafeAllow: ["constructor"] })
    console.log(await proxy.x());// x为2
    await proxy.cal();
    console.log(await proxy.x())// x为6
}

deploy();
