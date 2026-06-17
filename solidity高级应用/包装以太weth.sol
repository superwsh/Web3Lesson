// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// WETH概念: WETH代表"包装的以太"，是一种将以太（ETH）包装为ERC20标准代币的方法。
// 用户存入ETH时，将铸造出对应的ERC20代币；用户提取时，相应的ERC20代币将被销毁。
// 合约简化: 使用WETH可以避免编写两个分离的合约（一个针对ETH，一个针对ERC20代币）。通过交互WETH，任何支持ERC20的合约都可以间接支持ETH。
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract Weth is ERC20{
    event Deposit(address indexed owner,uint amount);
    event Withdraw(address indexed owner,uint amount);

    constructor() ERC20("Wrapped Ether", "WETH") {}

    receive() external payable { }
    //添加一个回退函数，以处理合约直接接收ETH的情况，并自动触发存款功能。
    fallback() external payable { 
        deposit();
    }

    function deposit() public  payable {
        _mint(msg.sender, msg.value);
        emit Deposit(msg.sender, msg.value);
    }

     function withdraw(uint amount) external  {
        _burn(msg.sender, amount);
        // payable (msg.sender).transfer(amount);
        (bool success,) = payable (msg.sender).call{value: amount}("");
        require(success, "call failed");
        emit Withdraw(msg.sender, amount);
    }
}