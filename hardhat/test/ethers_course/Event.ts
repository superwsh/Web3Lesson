/*
    获取链上event事件
 */
import { ethers } from "hardhat";

const url = `http://127.0.0.1:8545`; //本地网络测试
const provider = new ethers.JsonRpcProvider(url);

async function main() {
  const abi = [
    "function totalSupply() external view returns (uint256)",
    "function balanceOf(address account) external view returns (uint256)",
    "function transfer(address recipient, uint256 amount) external returns (bool)",
    "event Transfer(address indexed from, address indexed to, uint256 value)",
  ];

  const CONTRACT_ADDRESS = "0x610178da211fef7d417bc0e6fed39f05609ad788";

  const contract = new ethers.Contract(CONTRACT_ADDRESS, abi, provider);
  const blockNumber = await provider.getBlockNumber();
  //  获取最新区块的事件
  const events = await contract.queryFilter(
    "Transfer",
    blockNumber - 1,
    blockNumber,
  );
  console.log(events[0]);
}

main();
