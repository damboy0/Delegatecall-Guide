
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A {
    address public bAddress; // Address of Contract B
    uint256 public value;    // Value stored in Contract A's storage

    // Constructor accepts Contract B's address
    constructor(address _bAddress) {
        bAddress = _bAddress;
    }

    // Function to interact with Contract B using delegatecall
    function increment(uint256 _amount) external {
        // Prepare the function signature for `incrementValue(uint256)`
        bytes memory data = abi.encodeWithSignature("incrementValue(uint256)", _amount);

        // Use delegatecall to execute `incrementValue` in the context of Contract A
        (bool success, ) = bAddress.delegatecall(data);
        require(success, "delegatecall failed");
    }
}