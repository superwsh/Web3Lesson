/*
    只读contract对象
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

  const CONTRACT_ADDRESS = "0x5fbdb2315678afecb367f032d93f642f64180aa3";
  const contract = new ethers.Contract(CONTRACT_ADDRESS, abi, provider);

  const totalSupply = await contract.totalSupply();
  console.log(`totalSupply is ${totalSupply}`);

  const ACCOUNT_ADDRESS = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266";
  const balance = await contract.balanceOf(ACCOUNT_ADDRESS);
  console.log(`balance is ${balance}`);
}

main();
