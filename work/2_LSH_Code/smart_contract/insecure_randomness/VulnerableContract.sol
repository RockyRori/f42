// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UnsecureRandomness {
    address public winner;

    function pickWinner() public {
        // 使用不安全的随机数生成方法
        uint256 random = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender)));

        // 根据随机数选择获胜者
        if (random % 2 == 0) {
            winner = msg.sender;
        }
    }

    function getWinner() public view returns (address) {
        return winner;
    }
}
