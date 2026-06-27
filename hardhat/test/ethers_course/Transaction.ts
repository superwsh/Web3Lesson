/*
    发送一笔交易
 */
import { ethers } from "hardhat";
import { inputPrivateKey } from "../../helpers/prompt";

const url = `http://127.0.0.1:8545`; //本地网络测试
const provider = new ethers.JsonRpcProvider(url);

async function main() {
  const privateKey = await inputPrivateKey("请输入你的钱包私钥:");
  const wallet = new ethers.Wallet(privateKey, provider);
  const RECEIVER = "0x70997970C51812dc3A010C7d01b50e0d17dc79C8";

  const senderBalance = await provider.getBalance(wallet.getAddress());
  const receiverBalance = await provider.getBalance(RECEIVER);
  console.log(
    `Sender Balance before --> ${ethers.formatUnits(senderBalance, 18)} Eth`,
  );

  console.log(
    `Receiver Balance before --> ${ethers.formatUnits(
      receiverBalance,
      18,
    )} Eth`,
  );

  const receipt = await wallet.sendTransaction({
    to: RECEIVER,
    value: ethers.parseUnits("1", 18),
  });

  console.log("交易已发送", receipt);

  console.log("交易已上链", await receipt.wait());

  const senderBalanceAfter = await provider.getBalance(wallet.getAddress());
  const receiverBalanceAfter = await provider.getBalance(RECEIVER);
  console.log(
    `Sender Balance after --> ${ethers.formatUnits(
      senderBalanceAfter,
      18,
    )} Eth`,
  );

  console.log(
    `Receiver Balance after --> ${ethers.formatUnits(
      receiverBalanceAfter,
      18,
    )} Eth`,
  );
}

main();
