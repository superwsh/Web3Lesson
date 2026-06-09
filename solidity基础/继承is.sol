// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//=========在父合约的函数声明中使用 virtual 关键字，表明这些函数可以被子合约继承和修改
// 编程作业：Solidity 继承练习
// • 目标
// • ：创建一个 Solidity 程序，包含三个合约：ContractA，ContractB 和 ContractC。
// ◦ ContractA：定义两个函数 foo() 和 bar() ，返回字符串"A"。
// ◦ ContractB：继承 ContractA，重写 foo() 和 bar() ，使其返回字符串"B"。
// ◦ ContractC：继承 ContractB，只重写 bar() ，使其返回字符串"C"。
// • 任务：编写完整的合约代码，编译并部署合约，验证函数调用的结果符合预期。
contract ContractA {
    function foo() virtual public pure returns(string memory){
        return "A";
    }
    function bar() virtual public pure returns(string memory){
        return "A";
    }
    function baz() virtual public pure returns(string memory){
        return "Aaaa";
    }
}

contract ContractB is ContractA {
    function foo() override public pure returns(string memory){
        return "B";
    }
    function bar() virtual override public pure returns(string memory){
        return "B";
    }
}

contract ContractC is ContractB {
     function bar() override public pure returns(string memory){
        return "C";
    }
}

// 【多重继承】
// 编程作业： 编写⼀个Solidity合约，展⽰多重继承的使⽤。包括以下⼏个步骤：
// 1. 定义三个合约A、B和C。 。合约A有⼀个函数 。合约B继承合约A，并重写 。合约C继承合约B和A，并重写
// 2. 确保继承顺序正确：从最基础的合约到派⽣合约。
// 3. 编译并部署合约C ，验证合约C是否继承了所有的函数并重写成功

contract A {
    function foo() public pure virtual returns(string memory){
        return "A";
    }
    function a() public pure returns(string memory){
        return "This is A";
    }
}

contract B is A{
    function foo() public pure virtual override returns(string memory){
        return "A";
    }
    function b() public pure returns(string memory){
        return "This is B";
    }
}

contract C is A,B{
     function foo() public pure override(A, B) returns(string memory){
        return "C";
    }
}

// 【调用父合约构造函数】编程作业：
// 1. 声明父合约：
// ◦ 编写一个名为 S 的合约，包含一个字符串类型的状态变量 name 和一个接收 name 参数的构造函数。
// ◦ 编写一个名为 T 的合约，包含一个字符串类型的状态变量 text 和一个接收 text 参数的构造函数。
// 2. 创建继承合约：
// ◦ 编写一个名为 U 的合约，继承 S 和 T 。
// ◦ 在 U 的构造函数中调用 S 和 T 的构造函数，并传递相应的参数。
// 3. 混合构造函数参数：
// ◦ 编写一个名为 BB 的合约，继承 S 和 T 。
// ◦ 静态传递 S 的构造函数参数，动态传递 T 的构造函数参数。
// 4. 验证初始化顺序：
// ◦ 编写一个名为 B0 的合约，先继承 S 再继承 T ，验证构造函数的调用顺序。
// ◦ 编写一个名为 B2 的合约，先继承 T 再继承 S ，验证构造函数的调用顺序。

contract S {
    string public name;
    constructor(string memory _name){
        name = _name;
    }
}
contract T {
    string public tet;
    constructor(string memory _tet){
        tet = _tet;
    }
}
contract U is S,T{
    constructor(string memory _name,string memory _text) S(_name) T(_text) {}
}

contract BB is S("staticName"),T{
    constructor(string memory _text) T(_text) {}
}

// 初始化顺序由继承的顺序决定，而非调用顺序
contract B0 is S,T{
    constructor(string memory _name,string memory _text) S(_name) T(_text) {}
}

contract B1 is T,S{
    constructor(string memory _name,string memory _text) S(_name) T(_text) {}
}