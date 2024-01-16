// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../script/DeployMoodNft.s.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNftTest is Test {
    error MoodNft__OnlyOwnerCanFlipMood();

    DeployMoodNft deployer;
    MoodNft moodNft;

    string happySvgImageFile = vm.readFile("./images/happy.svg");
    string sadSvgImageFile = vm.readFile("./images/sad.svg");

    string happySvgImageUri;
    string sadSvgImageUri;

    address private user = makeAddr("user");

    function setUp() external {
        deployer = new DeployMoodNft();
        moodNft = deployer.run();

        happySvgImageUri = deployer.svgToImageURI(happySvgImageFile);
        sadSvgImageUri = deployer.svgToImageURI(sadSvgImageFile);
    }

    function getTokenURI(string memory imageUri) public view returns (string memory) {
        bytes memory dataURI = abi.encodePacked(
            '{"name":"',
            moodNft.name(),
            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
            imageUri,
            '"}'
        );

        return string(abi.encodePacked("data:application/json;base64,", Base64.encode(dataURI)));
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

    function test_HappySvgUri_IsSet() public mintMoodNft {
        uint256 tokenId = moodNft.getTokenCounter() - 1;
        // getTokenCounter will give the current tokenId
        // we have to check for the previous one

        assertEq(getTokenURI(happySvgImageUri), moodNft.tokenURI(tokenId));
    }

    function test_Owner() public mintMoodNft {
        uint256 tokenId = moodNft.getTokenCounter() - 1;
        address owner = moodNft.ownerOf(tokenId);
        assertEq(owner, user);
    }

    function test_FlipMood_FlipsTheMood_WhenCalledByOwner() public mintMoodNft {
        uint256 tokenId = moodNft.getTokenCounter() - 1;

        vm.startPrank(user);
        moodNft.flipMood(tokenId);
        vm.stopPrank();

        uint256 currentMood = moodNft.getCurrentMood(tokenId);

        assertEq(currentMood, 1);
        assertEq(getTokenURI(sadSvgImageUri), moodNft.tokenURI(tokenId));
    }

    function test_RevertsIf_FlipMood_NotCalledByOwner() public mintMoodNft {
        uint256 tokenId = moodNft.getTokenCounter() - 1;

        vm.expectRevert(MoodNft.MoodNft__OnlyOwnerCanFlipMood.selector);
        moodNft.flipMood(tokenId);
    }
}
