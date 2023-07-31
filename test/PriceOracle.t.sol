// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/PriceOracle.sol";
import "forge-std/console.sol";

contract PriceOracleTest is Test {
    PriceOracle public priceOracle;

    function setUp() public {
        priceOracle = new PriceOracle();
    }

    function testGetLatestPrice() public {
        console.log("Getting latest price");
        int price = priceOracle.getLatestPrice();
        console.logInt(price / 1e8);
    }
}
