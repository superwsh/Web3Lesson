// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StakeToken is ERC20 {
     constructor() ERC20("Wrapped Ether", "WETH") {}
    function mint(address account, uint amount) public {
        _mint(account, amount);
    }
}