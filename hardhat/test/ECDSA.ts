import { ethers, keccak256 } from "ethers";
import hardhat from "hardhat";

async function getMessageHash(message: string) {
    const hashBytes = ethers.toBeArray(
        keccak256(ethers.toUtf8Bytes(message))
    );
    //获取第一个账号用于加签
    const [account1] = await hardhat.ethers.getSigners();
    console.log(account1)

    console.log(await account1.signMessage(hashBytes))
}
getMessageHash("You are hansome");
