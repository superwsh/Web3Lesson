// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Counter {
    event CounterInc(uint count);
    uint public count;

    function inc() public {
        count++;
        emit CounterInc(count);
    }

    function getCount() public view returns (uint) {
        return count;
    }
}
