// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/Test.sol";
import "../src/ProofStamp.sol";

contract ProofStampTest is Test {
    ProofStamp public c;
    
    function setUp() public {
        c = new ProofStamp();
    }

    function testDeployment() public {
        assertTrue(address(c) != address(0));
    }
}
