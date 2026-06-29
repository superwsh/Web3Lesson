// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// Uncomment this line to use console.log
import "hardhat/console.sol";
library Sub {
    function sub(uint a, uint b) internal pure returns (uint c) {
        require((c = a - b) <= a, "BoringMath: Underflow");
    }
}

contract Miso is ERC20 {
    using Sub for uint;

    constructor(uint initial) ERC20("Miso", "MISO") {
        _mint((address(this)), initial);
    }

    function number(uint8 n) public pure returns (uint8 ret) {
        console.log(unicode"调用了number函数", n);
        ret = 10;
    }

    function batch(
        bytes[] calldata calls
    )
        external
        payable
        returns (bool[] memory successes, bytes[] memory results)
    {
        successes = new bool[](calls.length);
        results = new bytes[](calls.length);
        for (uint256 i = 0; i < calls.length; i++) {
            (bool success, bytes memory result) = address(this).delegatecall(
                calls[i]
            );
            successes[i] = success;
            results[i] = result;
        }
        return (successes, results);
    }


    function commitEth() external payable {
        console.log("msg.value: %s", msg.value, balanceOf(address(this)));
        uint ethToTransfer = msg.value;

        if (ethToTransfer > 0) {
            _addCommitment(ethToTransfer);
        }

        uint ethToRefund = msg.value.sub(ethToTransfer);

        if (ethToRefund > 0) {
            payable(msg.sender).transfer(ethToRefund);
        }
    }

    function _addCommitment(uint256 amount) internal {
        // 代币转账
        _transfer(address(this), msg.sender, amount);
    }
}
