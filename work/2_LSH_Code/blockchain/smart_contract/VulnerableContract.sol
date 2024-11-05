// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AccessControlVulnerability {
    address public owner;
    uint256 public funds;

    constructor() {
        // 合约的部署者为合约的所有者
        owner = msg.sender;
    }

    function deposit() public payable {
        funds += msg.value;
    }

    function withdraw(uint256 amount) public {
        // 未进行访问控制，任何人都可以调用此函数
        require(amount <= funds, "Insufficient funds");
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        funds -= amount;
    }

    function getFunds() public view returns (uint256) {
        return funds;
    }
}
