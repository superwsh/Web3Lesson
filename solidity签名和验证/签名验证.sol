// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


contract SignatureVerify {
    // 1. verify 函数，用于验证签名。
    // 签名由小狐狸生成（Account地址和哈希作为参数）
    function verify(string memory message, bytes memory sign,address signer) external pure returns (bool){
        bytes32 msgHash = getMessageHash(message);
        bytes32 ethSignedMsgHash = getEthSignedMessageHash(msgHash);
        return recover(ethSignedMsgHash, sign) == signer;
    }

    // 2. getMessageHash 函数，用于生成消息哈希。
    function getMessageHash(string memory message) public  pure returns(bytes32) {
        return keccak256(abi.encodePacked(message));
    }

    // 3. getEthSignedMessageHash 函数，用于生成Ethereum签名消息哈希。
    function getEthSignedMessageHash(bytes32 messageHash) public pure returns(bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash));
    }

    // 4. recover 函数，用于恢复签名者地址。
    function recover(bytes32 ethSignedMessageHash, bytes memory sign) public  pure returns(address) {
        (bytes32 r,bytes32 s,uint8 v) = splitSignature(sign);
        return ecrecover(ethSignedMessageHash, v, r, s);
    }

    // 5. splitSignature 函数，用于拆分签名。
    function splitSignature(bytes memory sign) internal pure returns(bytes32 r, bytes32 s, uint8 v) {
        assembly {
            r := mload(add(sign, 32))
            s := mload(add(sign, 64))
            v := byte(0,mload(add(sign, 96)))
        }
    }
}