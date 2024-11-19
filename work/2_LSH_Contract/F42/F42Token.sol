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

contract F42Token is IERC20 {
    // Token basic info.
    string public name = "F42Token";
    string public symbol = "F42";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    // Record balance of certain address.
    mapping(address => uint256) public balanceOf;
    // Record limit of certain address.
    mapping(address => mapping(address => uint256)) public allowance;

    // Set total coin via user input.
    // Give them to creater address.
    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply * 10**uint256(decimals);
        balanceOf[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    // Implementation of interface.
    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        require(_to != address(0), "Invalid address");
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // Implementation of interface.
    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        require(_spender != address(0), "Invalid address");

        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // Implementation of interface.
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(_to != address(0), "Invalid address");
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "Allowance exceeded");

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}
