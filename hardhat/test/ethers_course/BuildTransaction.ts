import { Contract } from "ethers";
import { ethers } from "hardhat";

const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

async function main() {
    const privateKey = "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80";
    const provider = new ethers.JsonRpcProvider("http://127.0.0.1:8545");

    const wallet = new ethers.Wallet(privateKey, provider);
    const nft = new Contract(contractAddress, ["function mint(address to) public"], provider);
    console.log("NFT mint to", wallet.address);

    // 获取nonce(交易计数)
    const nonce = await provider.getTransactionCount(wallet.address);
    // 获取gasPrice
    const { gasPrice } = await provider.getFeeData();
    // 获取chanId
    const { chainId } = await provider.getNetwork();
    // 对请求数据编码
    const data = nft.interface.encodeFunctionData("mint", [wallet.address]);
    const gasLimit = await provider.estimateGas({
        to: contractAddress,
        data
    });

    // 构建交易
    const unsignedTx = await nft.mint.populateTransaction(wallet.address, {
        gasLimit: gasLimit,
        gasPrice: gasPrice,
        nonce: nonce,
        from: wallet.address,
        chainId: chainId
    })
    console.log("Unsigned transaction", unsignedTx);

    const signedTx = await wallet.signTransaction(unsignedTx);
    await provider.send("eth_sendRawTransaction", [signedTx]);
}

main()