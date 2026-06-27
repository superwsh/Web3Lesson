/*
    通过ethers的JsonRpcProvider获取以太坊网络连接
 */
import { ethers } from "hardhat";

const url = `https://api.zan.top/node/v1/eth/mainnet/${process.env.ZAN_API_KEY}`;
const provider = new ethers.JsonRpcProvider(url);

const ADDRESS = "0x4838B106FCe9647Bdf1E7877BF73cE8B0BAD5f97";

async function main() {
  const balance = await provider.getBalance(ADDRESS);
  console.log(
    `Balance of ${ADDRESS} --> ${ethers.formatUnits(balance, 18)} Eth`,
  );
}

main();
