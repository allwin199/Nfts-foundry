// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../script/DeployMoodNft.s.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MoodNftTest is Test {
    DeployMoodNft deployer;
    MoodNft moodNft;

    address private user = makeAddr("user");

    function setUp() external {
        deployer = new DeployMoodNft();
        moodNft = deployer.run();
    }

    function test_NFT_NameIsSet() public {
        assertEq(moodNft.name(), "Mood Nft");
    }

    modifier mintMoodNft() {
        vm.startPrank(user);
        moodNft.mintNft();
        vm.stopPrank();
        _;
    }

    function test_UserCan_MintNft_AndHaveBalance() public mintMoodNft {
        uint256 userBalance = moodNft.balanceOf(user);
        assertEq(userBalance, 1);
    }

    function test_CurrentMood_AfterMinting() public mintMoodNft {
        uint256 currentMood = moodNft.getCurrentMood(0);
        assertEq(currentMood, 0);
    }
}
