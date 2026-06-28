import { ethers } from "hardhat";

//创建钱包账户
function generateAccount() {
  //创建随机钱包账号
  const randomWallet = ethers.Wallet.createRandom();
  console.log("Private key: ", randomWallet.privateKey);
  console.log("Account address: ", randomWallet.address);

  //根据私钥获取钱包账号
  const PRIVATE_KEY =
    "0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d";
  const wallet = new ethers.Wallet(PRIVATE_KEY);
  console.log("Address from private key: ", wallet.address);
}

//验证地址是否有效
function validateAddress() {
  const address = "0x9e66523303bea11056cc719515d7287bbe777c15";

  if (ethers.isAddress(address)) {
    //格式化为EIP-55标准格式的地址
    const format = ethers.getAddress(address);
    console.log("Format address from EIP-55: ", format);
  } else {
    console.log("Invalid address");
  }
}

//单位转换
function uintConvert() {
  // Eth转换为wei
  const ethValue = "1.5";
  const weiValue = ethers.parseEther(ethValue);
  console.log(`${ethValue} ETH =  ${weiValue} Wei`);

  // wei转换为eth
  const bigWeiValue = ethers.getBigInt("1500000000000000000");
  const convertEthValue = ethers.formatEther(bigWeiValue);
  console.log(`${bigWeiValue} Wei =  ${convertEthValue} ETH`);

  // gwei转换为wei
  const gweiValue = "20";
  const weiFormatGwei = ethers.parseUnits(gweiValue, "gwei");
  console.log(`${gweiValue} Gwei =  ${weiFormatGwei.toString()} wei`);

  // wei转换为gwei
  const formatGwei = ethers.formatUnits(weiFormatGwei, "gwei");
  console.log(`${weiFormatGwei.toString()} Wei =  ${formatGwei} Gwei`);
}

//keccak256、abi编码
function hashcodes() {
  const address = "0x90F79bf6EB2c4f870365E785982E1f101E93b906";
  const number = "123456";

  // 编码
  const encodeData = ethers.AbiCoder.defaultAbiCoder().encode(
    ["address", "uint256"],
    [address, number],
  );
  console.log("Encode data: ", encodeData);

  //解码
  const decode = ethers.AbiCoder.defaultAbiCoder().decode(
    ["address", "uint256"],
    encodeData,
  );
  console.log("Decode address: ", decode[0]);
  console.log("Decode number: ", decode[1]);

  // 获取经过压缩编码后的keccak256哈希
  const packedHash = ethers.solidityPackedKeccak256(
    ["address", "uint256"],
    [address, number],
  );
  console.log("Keccak256 hash: ", packedHash);
}

hashcodes();
