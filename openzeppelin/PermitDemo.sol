// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {
    ERC20Permit
} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract PermitDemo is ERC20, ERC20Permit {
    constructor(
        address recipient
    ) ERC20("PermitDemo", "Demo") ERC20Permit("PermitDemo") {
        _mint(recipient, 100 * 10 ** decimals());
    }
}
