// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";

contract ECDSAVerifySign {
    using ECDSA for bytes32;
    using MessageHashUtils for bytes32;
    function recover(string memory message,bytes memory sign) public pure returns(address){
        bytes32 hash = keccak256(bytes(message));
        return MessageHashUtils.toEthSignedMessageHash(hash).recover(sign);
    }
}