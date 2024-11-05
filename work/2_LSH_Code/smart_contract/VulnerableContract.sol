// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableContract {
    address public owner;
    mapping(address => uint256) public balances;
    address[] public users;
    address public topDonor;
    uint256 public highestDonation;

    constructor() {
        // 访问控制漏洞：合约部署者未被正确设为所有者
        owner = msg.sender;
    }

    // 添加用户并记录捐赠
    function donate() public payable {
        require(msg.value > 0, "Must send some ether");

        // 不安全的随机性：基于区块时间戳的随机选择
        if (block.timestamp % 2 == 0) {
            topDonor = msg.sender;
        }

        if (balances[msg.sender] == 0) {
            users.push(msg.sender);
        }

        // 更新捐赠金额
        balances[msg.sender] += msg.value;

        // 更新最高捐赠者
        if (balances[msg.sender] > highestDonation) {
            highestDonation = balances[msg.sender];
            topDonor = msg.sender;
        }
    }

    // 存款功能
    function deposit() public payable {
        // 更新余额
        balances[msg.sender] += msg.value;
    }

    // 未经检查的外部调用：用户可以提取自己的余额，但未检查外部调用结果
    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "Insufficient balance");

        // 可能的重入攻击漏洞：未正确更新余额
        msg.sender.call{value: amount}("");

        // 更新余额，即使调用失败
        balances[msg.sender] = 0;
    }

    // 访问控制漏洞：任何人都可以调用此函数，而非仅限所有者
    function distributeFunds() public {
        require(users.length > 0, "No users to distribute funds to");
        uint256 amountPerUser = address(this).balance / users.length;

        // 对每个用户分发资金，但可能超过燃料限制
        for (uint256 i = 0; i < users.length; i++) {
            users[i].call{value: amountPerUser}("");
        }
    }

    // 时间戳依赖：基于区块时间戳的判断逻辑
    function playGame() public {
        if (block.timestamp % 2 == 0) {
            // 如果区块时间戳为偶数，用户获胜
            topDonor = msg.sender;
        }
    }
}
