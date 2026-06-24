import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-gas-reporter";
const dotenv = require("dotenv");
dotenv.config();

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.28",
    settings: {
      evmVersion: "cancun", // 关键：设置为cancun
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  gasReporter: {
    enabled: false
  },
  networks: {
    sepolia: {
      url: `https://api.zan.top/node/v1/eth/sepolia/${process.env.ZAN_API_KEY}`,
      accounts: [process.env.PRIVATE_KEY!]
    }
  },
  etherscan: {
    enabled: false
  },
  sourcify: {
    enabled: true
  }
};

export default config;
