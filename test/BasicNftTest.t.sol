// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;

    address public user = makeAddr("user");

    string constant PUG_TOKEN_URI = "ipfs://bafybeietajviz34cqtxjuv74orhpakbi2th5qok5qscym4a5srskverxua/";

    function setUp() external {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function test_NftNameIs_SetCorrectly() public view {
        string memory expectedName = "Dogie";
        // assertEq(expectedName, basicNft.name());

        // assert(expectedName == basicNft.name());
        // Built-in binary operator == cannot be applied to types string memory and string memory.
        // Reason for the above error is, we know string are array of bytes
        // When we compare 2 strings directly we are comparing 2 arrays and checking they are same

        // To solve this we can do abi.encodePacked()
        // abi.encodePacked() will return a bytes object, If we do keccack(output) it will return the hash
        // hash is a function which returns a fixed size unique string that identifies that object

        bytes memory expectNameEncoded = abi.encodePacked(expectedName);
        bytes memory actualNameEncoded = abi.encodePacked(basicNft.name());

        assert(keccak256(expectNameEncoded) == keccak256(actualNameEncoded));
    }

    function test_UserCanMint_AndHaveBalance() public {
        vm.startPrank(user);
        basicNft.mintNft(PUG_TOKEN_URI);
        vm.stopPrank();

        uint256 userBalance = basicNft.balanceOf(user);
        assertEq(userBalance, 1);
    }

    function test_UserCanMint_AndTokenUri_IsSet() public {
        vm.startPrank(user);
        basicNft.mintNft(PUG_TOKEN_URI);
        vm.stopPrank();

        string memory tokenUri = basicNft.tokenURI(0);
        assertEq(tokenUri, PUG_TOKEN_URI);

        // we can assert()
        // assert(keccak256(abi.encodePacked(tokenUri)) == keccak256(abi.encodePacked(PUG_TOKEN_URI)));
    }
}
