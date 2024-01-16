// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MintBasicNft is Script {
    string constant PUG_TOKEN_URI = "ipfs://bafybeietajviz34cqtxjuv74orhpakbi2th5qok5qscym4a5srskverxua/";

    function mintNftOnContract(address basicNft) public {
        vm.startBroadcast();
        BasicNft(basicNft).mintNft(PUG_TOKEN_URI);
        vm.stopBroadcast();
    }

    function run() external {
        // get the deployed contract using devopstools
        address deployedBasicNft = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(deployedBasicNft);
    }
}

contract MintMoodNft is Script {
    address deployedMoodNft;

    function flipMood(uint256 tokenId) public {
        vm.startBroadcast();
        MoodNft(deployedMoodNft).flipMood(tokenId);
        vm.stopBroadcast();
    }

    function mintMoodNftOnContract(address _deployedMoodNft) public {
        vm.startBroadcast();
        MoodNft(_deployedMoodNft).mintNft();
        vm.stopBroadcast();
    }

    function run() external {
        // get the deployed contract using devopstools
        deployedMoodNft = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        mintMoodNftOnContract(deployedMoodNft);
    }
}
