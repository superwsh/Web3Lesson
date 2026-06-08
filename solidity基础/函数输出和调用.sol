// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultipleOutputs {
    uint public number;
    bool public flag;
    string public text;

    function returnMultiple() public pure returns (uint, bool, string memory) {
     return (256, true, "Hello, Solidity!");
    }
    function captureOutputs() public {
        (number, flag, text) = returnMultiple();
    }
    function displayOutputs() public view returns (uint, bool, string memory) {
        return (number, flag, text);
    }
}
