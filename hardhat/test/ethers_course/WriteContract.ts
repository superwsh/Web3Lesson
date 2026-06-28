/*
    可写入contract对象
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
  const SENDER = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266";
  const RECEIVER = "0x70997970C51812dc3A010C7d01b50e0d17dc79C8";

  const PRIVATE_KEY =
    "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80";
  //获取指定网络的钱包
  const wallet = new ethers.Wallet(PRIVATE_KEY, provider);
  //钱包连接合约
  const contract = new ethers.Contract(CONTRACT_ADDRESS, abi, wallet);

  const balance1 = await contract.balanceOf(SENDER);
  const balance2 = await contract.balanceOf(RECEIVER);
  console.log(`交易前，SENDER balance is ${balance1}`);
  console.log(`交易前，RECEIVER balance is ${balance2}`);

  //钱包调用合约发起交易
  const transaction = await contract.transfer(RECEIVER, 100);
  await transaction.wait();
  console.log(transaction);

  const balance3 = await contract.balanceOf(SENDER);
  const balance4 = await contract.balanceOf(RECEIVER);
  console.log(`交易后，SENDER balance is ${balance3}`);
  console.log(`交易后，RECEIVER balance is ${balance4}`);
}

main();
