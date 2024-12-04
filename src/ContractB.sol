// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract B {
    // Function to increment a value in storage
    function incrementValue(uint256 _amount) external {
        assembly {
            // Load the second storage slot (slot 1) 
            let slot := 1
            let current := sload(slot)
            let updated := add(current, _amount)
            sstore(slot, updated)
        }
    }
}