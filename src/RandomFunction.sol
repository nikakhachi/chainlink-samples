// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "chainlink/contracts/src/v0.8/vrf/VRFV2WrapperConsumerBase.sol";

contract RandomFunction is VRFV2WrapperConsumerBase {
    address public constant LINK_ADDRESS =
        0x326C977E6efc84E512bB9C30f76E30c160eD06FB;
    address constant VRF_WRAPPER = 0x708701a1DfF4f478de54383E49a627eD4852C816;
    address constant VRF_COORDINATOR =
        0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D;
    uint32 constant CALLBACK_GAS_LIMIT = 1000000;
    uint32 constant NUM_WORDS = 1;
    uint16 constant REQUEST_CONFIRMATIONS = 3;

    mapping(uint256 => uint256) public statuses;

    constructor() VRFV2WrapperConsumerBase(LINK_ADDRESS, VRF_WRAPPER) {}

    function flip() external returns (uint256 requestId) {
        requestId = requestRandomness(
            CALLBACK_GAS_LIMIT,
            REQUEST_CONFIRMATIONS,
            NUM_WORDS
        );
    }

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) internal override {
        statuses[requestId] = randomWords[0];
    }

    function getStatus(uint256 requestId) public view returns (uint256) {
        return statuses[requestId];
    }
}
