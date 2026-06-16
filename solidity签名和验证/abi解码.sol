// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract AbiDecode{
    struct MyStruct {
       string name;
       uint[2] nums;
    }

    function encodeData(
        uint x,address addr,uint[] memory arr,MyStruct memory myStruct
    ) external pure returns(bytes memory){
        return abi.encode(x, addr, arr, myStruct);
    }

    function decodeData(bytes memory data) external pure returns (
        uint x, address addr, uint[] memory arr, MyStruct memory myStruct
    )  {
        (x, addr, arr, myStruct) = abi.decode(data, (uint, address, uint[], MyStruct));
    }
}