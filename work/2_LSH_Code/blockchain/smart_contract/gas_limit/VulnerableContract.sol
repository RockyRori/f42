// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GasLimitVulnerability {
    address public owner;
    mapping(address => uint256) public balances;
    address[] public users;

    constructor() {
        owner = msg.sender;
    }

    // 添加用户到列表中，并记录其余额
    function addUser(address user) public payable {
        require(msg.value > 0, "Must send some ether");

        if (balances[user] == 0) {
            users.push(user);
        }
        balances[user] += msg.value;
    }

    // 分发合约的所有余额给所有用户
    function distributeFunds() public {
        require(msg.sender == owner, "Only owner can distribute funds");
        uint256 amountPerUser = address(this).balance / users.length;

        // 对每个用户分发资金
        for (uint256 i = 0; i < users.length; i++) {
            (bool success, ) = users[i].call{value: amountPerUser}("");
            require(success, "Transfer failed");
        }
    }

    function getUserCount() public view returns (uint256) {
        return users.length;
    }
}
