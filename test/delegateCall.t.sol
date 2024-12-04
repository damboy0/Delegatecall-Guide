// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ContractA.sol";
import "../src/ContractB.sol";

contract TestDelegateCall is Test {

    A aContract;
    B bContract;

    function setUp() public {
        //Deploy contractB
        bContract = new B();

        //Deploy contractA passing the address of contractB
        aContract = new A(address(bContract));
    }


    // To test if the delagatecall updates the storage
    function testDelegateCallUpdateStorage() public {
        // Increment the value in Contract A's context
        aContract.increment(10);

         // Verify that Contract A's storage is updated
        uint256 aValue = aContract.value();
        assertEq(aValue, 10, "ContractA Value not updated correctly, it should be 10");


        // Verify that Contract B's storage is not updated
        bytes32 slotB = vm.load(address(bContract), bytes32(0));
        assertEq(slotB, 0, "ContractB storage should remain unchainged");
    }
    

    //To test if it fails if a nonexistent function is called
    function testDelegateCallFail() public {
        //Verify that Contract A's storage is not updated

        bytes memory invalidData = abi.encodeWithSignature("nonexistentFunction()");
        (bool success,) = address(aContract).call(invalidData);

        
        assertEq(success, false, "Delegatecall should fail as the function is not defined");
    }
}