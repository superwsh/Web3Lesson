import { ethers } from "ethers";
import hardhat from "hardhat";

// 生成 EIP-712 Permit 链下签名
// 签名内容必须与合约 ERC20Permit 的 EIP-712 domain 完全一致：
//   name: token.name() (合约构造中 ERC20Permit 接收的名称)
//   version: "1" (OpenZeppelin 默认)
//   nonce: token.nonces(owner) (当前 nonce，每次 permit 后递增)
export async function getPermitSignature(
  wallet: ethers.Signer,
  token: any,
  spender: string,
  value: bigint,
  deadline: bigint
) {
  const provider = wallet.provider!;

  const [contractName, nonce, owner, network, verifyingContract] =
    await Promise.all([
      token.name(),
      token.nonces(wallet.getAddress()),
      wallet.getAddress(),
      provider.getNetwork(),
      token.getAddress(),
    ]);

  return ethers.Signature.from(
    await wallet.signTypedData(
      {
        name: contractName,
        version: "1",
        chainId: network.chainId,
        verifyingContract,
      },
      {
        Permit: [
          { name: "owner", type: "address" },
          { name: "spender", type: "address" },
          { name: "value", type: "uint256" },
          { name: "nonce", type: "uint256" },
          { name: "deadline", type: "uint256" },
        ],
      },
      {
        owner,
        spender,
        value,
        nonce,
        deadline,
      }
    )
  );
}

async function main() {
  //获取账号列表的第一个和第二个
  const [signer1, signer2] = await hardhat.ethers.getSigners();
  //部署合约
  const factory = await hardhat.ethers.getContractFactory("PermitDemo");
  const token = await factory.deploy(signer1.address);
  await token.waitForDeployment();
  console.log("合约地址:", await token.getAddress());

  const allowance = ethers.parseUnits("100", 18); // 授权 spender 100 个代币
  const MAXUint256 = ethers.MaxUint256;            // 永不过期

  //生成签名
  const { r, s, v } = await getPermitSignature(
    signer1,
    token,
    signer2.address,
    allowance,
    MAXUint256
  );
  //调用permit授权给spender
  await token.permit(
    signer1.address,
    signer2.address,
    allowance,
    MAXUint256,
    v,
    r,
    s
  );

  const newAllowance = await token.allowance(signer1.address, signer2.address);
  console.log("permit 成功, allowance:", newAllowance.toString());
}

main().catch(console.error);
