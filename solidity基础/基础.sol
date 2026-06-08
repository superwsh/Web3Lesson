// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract HelloWrold {
    string public myStr = "Hello World!";
    bool b = true;
    uint public u = 123;//无符号 unit=unit256 数值为0到2^256-1
    int public i = -123;//有符号 数值为-2^255到2^255-1
    int public maxInt = type(int).max;
    int public minInt = type(int).min;

    address public addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    // bytes32 public b32  
    function add(uint x,uint y) external pure returns(uint){
        return x + y;
    }
    function sub(uint x,uint y) external pure returns(uint){
        return x - y;
    }

    //view关键字表示函数可以读取状态变量和全局变量
    function viewGlobalInfo() external view returns (address, uint,  uint){
        address sender = msg.sender;//全局变量：调用者地址
        uint timestamp = block.timestamp;//全局变量：时间戳
        uint blockNum = block.number;//全局变量：块高
        return (sender, timestamp, blockNum);
    }
}

//常量节省gas费
contract Constant{
    address public constant MY_ADDR = 0xf8e81D47203A594245E36C48e151709F0C19fBe8;//373 gas
    uint public constant MY_UINT = 123;
}
contract Var{
    address public MY_ADDR = 0xf8e81D47203A594245E36C48e151709F0C19fBe8;//2485 gas
}