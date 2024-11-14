// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TimestampDependency {
    address public winner;

    function play() public {
        // 通过区块时间戳生成一个伪随机数
        if (block.timestamp % 2 == 0) {
            // 时间戳为偶数时，调用者成为赢家
            winner = msg.sender;
        }
    }

    function getWinner() public view returns (address) {
        return winner;
    }
}
