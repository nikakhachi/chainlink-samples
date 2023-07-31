// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/RandomFunction.sol";
import "forge-std/console.sol";
// import IERC interface from openzeppelin that is inside chainlink repository
import "chainlink/contracts/foundry-lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract RandomFunctionTest is Test {
    uint256 goerliFork;
    RandomFunction public randomFunction;

    string GOERLI_RPC_URL = vm.envString("GOERLI_RPC_URL");

    function setUp() public {
        goerliFork = vm.createFork(GOERLI_RPC_URL);

        vm.selectFork(goerliFork);
        randomFunction = new RandomFunction();

        IERC20 link = IERC20(randomFunction.LINK_ADDRESS());

        uint256 balance = link.balanceOf(
            0xf05F17d6Fb0C5C3d431059d6064bD8e0352dfadf
        );
        console.log("Balance: %s", balance);
        vm.prank(0xf05F17d6Fb0C5C3d431059d6064bD8e0352dfadf);
        link.transfer(address(randomFunction), balance);
    }

    function testFlip() public {
        console.log("Flipping coin");
        uint256 requestId = randomFunction.flip();
        console.log("Request ID: %s", requestId);
    }
}
