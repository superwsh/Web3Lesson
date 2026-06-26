// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract UUPSV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint public x;

    function _authorizeUpgrade(address newImplementation) internal override {}

    //initializer代表这个函数只能被执行一次
    function initialize(uint val) external initializer {
        x = val;
        __Ownable_init(msg.sender);
    }

    function cal() external {
        x += 1;
    }
}
