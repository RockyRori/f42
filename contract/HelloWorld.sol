// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HelloWorld {
    string private helloMessage; // This variable will store our "hello world" message.

    // Constructor to initialize the contract with the message.
    constructor() {
        helloMessage = "Hello, World!";
    }

    // Function to retrieve the "hello world" message.
    function getHelloMessage() public view returns (string memory) {
        return helloMessage;
    }
}
