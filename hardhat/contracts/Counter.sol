// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract Counter {
    event CounterInc(uint count);
    uint public count;

    function inc() public {
        count++;
        console.log("Now, Counter is", count);
        emit CounterInc(count);
    }

    function getCount() public view returns (uint) {
        return count;
    }
}
