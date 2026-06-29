import { ethers } from "hardhat";

async function main() {
    /**
    * hashMessage的组成(https://eips.ethereum.org/EIPS/eip-191)
    * 
    * 消息头部："\x19Ethereum Signed Message:\n";()
    * message⻓度hash
    * message内容hash
    */
    const MessagePrefix = "\x19Ethereum Signed Message:\n";
    const message = "0x1234";
    /**
    * 转换成字符hash
    */
    const utf8 = ethers.toUtf8Bytes(message);
    const msg = ethers.concat([
        ethers.toUtf8Bytes(MessagePrefix),
        ethers.toUtf8Bytes(String(utf8.length)),
        utf8
    ])
    console.log('消息hash:', msg)

    /**
    * 转成256
    */
    console.log('keccak256:', ethers.keccak256(msg))
    console.log('hashMessage:', ethers.hashMessage(message))

    const privateKey = "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80";
    const wallet = new ethers.Wallet(privateKey);
    const ethSignFromWallet = wallet.signMessageSync("You are hansome");

    const verifyAddress = ethers.verifyMessage("You are hansome", ethSignFromWallet);
    console.log('验证签名地址:', verifyAddress == await wallet.getAddress())
}
main()