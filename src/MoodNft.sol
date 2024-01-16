// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// internal & private view & pure functions
// external & public view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

//////////////////////////////////////////////////////////
//////////////////////  Imports  /////////////////////////
//////////////////////////////////////////////////////////
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

/// @title Mood NFT
/// @author Prince Allwin
/// @notice Mood NFT metadata is 100% hosted on-chain
contract MoodNft is ERC721 {
    //////////////////////////////////////////////////////////
    ////////////////////  Custom Errors  /////////////////////
    //////////////////////////////////////////////////////////
    error MoodNft__OnlyOwnerCanFlipMood();

    //////////////////////////////////////////////////////////
    ////////////////  Type Declarations  /////////////////////
    //////////////////////////////////////////////////////////
    enum Mood {
        HAPPY,
        SAD
    }

    //////////////////////////////////////////////////////////
    ////////////////  Storage Variables  /////////////////////
    //////////////////////////////////////////////////////////
    uint256 private s_tokenCounter;
    string private s_imageUri;
    string private s_happySvgImageUri;
    string private s_sadSvgImageUri;

    mapping(uint256 tokenId => Mood) private s_tokenIdToMood;

    //////////////////////////////////////////////////////////
    //////////////////////  Functions  ///////////////////////
    //////////////////////////////////////////////////////////

    // encoded svg images are passed to save gas
    // ImageUri's are passed not the tokenUri
    constructor(string memory happySvgImageUri, string memory sadSvgImageUri) ERC721("Mood Nft", "MOOD") {
        s_tokenCounter = 0;
        s_happySvgImageUri = happySvgImageUri;
        s_sadSvgImageUri = sadSvgImageUri;
    }

    function flipMood(uint256 tokenId) public {
        if (ownerOf(tokenId) != msg.sender) {
            revert MoodNft__OnlyOwnerCanFlipMood();
        }
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter = s_tokenCounter + 1;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageUri;

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageUri = s_happySvgImageUri;
        } else {
            imageUri = s_sadSvgImageUri;
        }

        bytes memory dataURI = abi.encodePacked(
            '{"name":"',
            name(),
            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
            imageUri,
            '"}'
        );

        return string(abi.encodePacked("data:application/json;base64,", Base64.encode(dataURI)));
    }

    //////////////////////////////////////////////////////////
    ///////  external & public view & pure functions  ////////
    //////////////////////////////////////////////////////////
    function getCurrentMood(uint256 tokenId) external view returns (uint256) {
        return uint256(s_tokenIdToMood[tokenId]);
    }

    function getTokenCounter() external view returns (uint256) {
        return s_tokenCounter;
    }
}
