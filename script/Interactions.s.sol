// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract MintBasicNft is Script {
    string constant PUG_TOKEN_URI = "ipfs://bafybeietajviz34cqtxjuv74orhpakbi2th5qok5qscym4a5srskverxua/";
    // string constant PUG_TOKEN_URI =
    //     "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

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
