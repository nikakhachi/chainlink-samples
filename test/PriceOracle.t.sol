// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/PriceOracle.sol";
import "forge-std/console.sol";

contract PriceOracleTest is Test {
    uint256 mainnetFork;
    PriceOracle public priceOracle;

    string MAINNET_RPC_URL = vm.envString("MAINNET_RPC_URL");

    function setUp() public {
        mainnetFork = vm.createFork(MAINNET_RPC_URL);

        vm.selectFork(mainnetFork);
        priceOracle = new PriceOracle();
    }

    function testGetLatestPrice() public {
        console.log("Getting latest price");
        int price = priceOracle.getLatestPrice();
        console.logInt(price / 1e8);
    }
}
