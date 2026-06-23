import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-gas-reporter"

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  //配置网络
  /*  networks: {
     sepolia_eth: {
       url: `https://eth-sepolia.g.alchemy.com/v2/${process.env.ALCHEMY_API_KEY}`,//测试网地址
       accounts: [process.env.PRIVATE_KEY] //用于支付的钱包账号私钥
     }
   } */
  gasReporter: {
    enabled: true
  }
};

export default config;
