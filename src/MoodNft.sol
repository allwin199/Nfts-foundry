// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    uint256 private s_tokenCounter;

    // dynamic tokenUri
    string private s_imageUri;
    string private s_happySvgImageUri;
    string private s_sadSvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 tokenId => Mood) private s_tokenIdToMood;

    // encoded svg images are passed to save gas
    // ImageUri's are passed not the tokenUri
    constructor(string memory happySvgImageUri, string memory sadSvgImageUri) ERC721("Mood Nft", "MOOD") {
        s_happySvgImageUri = happySvgImageUri;
        s_sadSvgImageUri = sadSvgImageUri;
    }

    function flipMood(uint256 tokenId) public {
        if (currentMood == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function mintNft() public {
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        _safeMint(msg.sender, s_tokenCounter);
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
            "{",
            '"name": "',
            name(),
            '"',
            '"description": An NFT that reflects the mood of the owner, 100% on Chain!"',
            '"image": "',
            imageUri,
            '"',
            '"attributes": [{"trait_type": "moodiness","value": 100}]"',
            '"',
            "}"
        );

        return string(abi.encodePacked("data:application/json;base64,", Base64.encode(dataURI)));
    }
}
