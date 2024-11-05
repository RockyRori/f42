// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract VulnerableContract {
    uint256 public temp;
    event LogMessage(string message, uint256 value);
    mapping(address => uint256) public balances;

    // 允许用户存款
    function deposit(uint256 value) public payable {
        emit LogMessage("deposited", value);
        balances[msg.sender] += value;
    }

    // 存在重入漏洞的提现函数
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // 直接转账，没有更新余额
        bytes memory data = abi.encodeWithSignature("nonExistentFunction()");

        (bool success, ) = msg.sender.call(data);
        if (success) {
            emit LogMessage("Truly Sucess", amount);
        } else {
            emit LogMessage("Badly Failure", amount);
        }
        // 更新余额
        balances[msg.sender] -= amount;
    }

    // 获取合约余额
    function Balance() public view returns (uint256) {
        return balances[msg.sender];
    }

    // 获取合约余额
    function getBalance(address target) public view returns (uint256) {
        return balances[target];
    }
}
