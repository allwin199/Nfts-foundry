// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract DeployBasicNft is Script {
    address deployerKey;

    function run() external returns (BasicNft) {
        if (block.chainid == 31337) {
            deployerKey = vm.envAddress("ANVIL_KEYCHAIN");
        } else {
            deployerKey = vm.envAddress("SEPOLIA_KEYCHAIN");
        }

        vm.startBroadcast(deployerKey);
        BasicNft basicNft = new BasicNft();
        vm.stopBroadcast();

        return basicNft;
    }
}
