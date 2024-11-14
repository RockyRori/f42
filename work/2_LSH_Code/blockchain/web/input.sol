// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IERC20 {
    // Function Definition

    // It return the total coin amount of self defined contract.
    function totalSupply() external view returns (uint256);

    // Check the balance of specific address.
    function balanceOf(address account) external view returns (uint256);

    // Transfer coin from sender to receiver.
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    // Check limit given by owner.
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    // Allow third party to manipulate transaction no more than limit.
    function approve(address spender, uint256 limit) external returns (bool);

    // Third party transfer coin with permission of sender address.
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    // Event Definition

    // Broadcast transfer action.
    event Transfer(address indexed from, address indexed to, uint256 value);
    // Broadcast approve action.
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}
