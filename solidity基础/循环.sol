// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract IfElse{
    function example (uint _x) public pure returns (uint) {
        if(_x < 10){
            return 1;
        }else if(_x < 20){
            return 2;
        }else{
            return 3;
        }
    }

    function tenary (uint _x) public pure returns (uint) {
        return _x < 10 ? 1 : 2;
    }
}

contract ForWhileLoop{
    function loop() external pure {
        for(uint i = 0;i < 10;i++){
            if(i == 3){
                continue ;
            }
            if(i == 5){
                break ;
            }
        }
        uint j = 10;
        while (j < 10){
            j++;
        }
    }

    function sum(uint number) external pure returns(uint){
        uint total;
        for(uint i = 0;i <= number;i++){
            total += i;
        }
        return total;
    }
}