import { ethers } from "ethers";
import Counter from "../artifacts/contracts/Counter.sol/Counter.json"

//获取小狐狸钱包的以太坊网络
function getEth() {
    const eth = window.ethereum;
    if (!eth) {
        throw new Error("No ethereum provider found");
    }
    return eth;
}
//判断钱包下是否有账号
async function requestAccess() {
    const metamask = getEth();
    const accounts = await metamask.request({ method: "eth_requestAccounts" }) as string[];
    return accounts && accounts.length > 0
}
//判断是否有支付付费的账号
async function hasSigners() {
    const metamask = getEth();
    const singers = await metamask.request({ method: "eth_accounts" }) as string[];
    return singers.length > 0
}

//调用合约
async function callContract() {
    if (!await hasSigners() && !await requestAccess()) {
        throw new Error("No ethereum provider found");
    }
    //通过浏览器获取以太坊网络支持
    const provider = new ethers.BrowserProvider(getEth());
    const address = process.env.CONTRACT_ADDRESS!;
    //部署合约到以太网
    const contract = new ethers.Contract(
        address,
        Counter.abi,//读取编译后的合约abi信息
        await provider.getSigner()
    );
    const div = document.createElement("div");
    async function getCount() {
        div.innerHTML = await contract.getCount();
    }
    getCount();

    const btn = document.createElement("button");
    btn.innerHTML = "inc";
    btn.onclick = async function () {
        await contract.inc();
        // const count = await getCount();
        // const tx = await contract.inc();//提交transaction
        // await tx.wait();//等待transaction提交完成
    }
    //监听合约的事件，更新count
    contract.on(contract.filters.CounterInc(), async function ({ args }) {
        div.innerHTML = args[0] || await contract.inc();
    });
    document.body.appendChild(div);
    document.body.appendChild(btn);

}

callContract();