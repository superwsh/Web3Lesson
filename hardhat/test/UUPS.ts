import hre, { ethers } from "hardhat";
import "@openzeppelin/hardhat-upgrades";

async function deploy() {
    const UUPSV1 = await ethers.getContractFactory("UUPSV1");
    const proxy = await hre.upgrades.deployProxy(
        UUPSV1,
        [1],
        {
            initializer: "initialize",
            kind: "uups"
        }
    )

    await proxy.waitForDeployment();
    console.log("Proxy contract address is ", await proxy.getAddress());
    console.log(await proxy.x());
    await proxy.cal();
    console.log(await proxy.x());


    const UUPSV2 = await ethers.getContractFactory("UUPSV2");
    const newContrat = await hre.upgrades.upgradeProxy(await proxy.getAddress(), UUPSV2);
    console.log(await newContrat.getAddress())
    console.log(await proxy.x());
    await proxy.cal();
    console.log(await proxy.x());
}

deploy();