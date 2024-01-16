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

/// @title Basic NFT
/// @author Prince Allwin
/// @notice This contract is creating Dogie NFTs
contract BasicNft is ERC721 {
    //////////////////////////////////////////////////////////
    ////////////////  Storage Variables  /////////////////////
    //////////////////////////////////////////////////////////
    uint256 private s_tokenCounter;

    /// @dev Each "Dogie" NFT will get it's `tokenId`, so everything will be unique
    /// @dev unique nft is based on the contract address which basically represents the collection and then the `tokenId`
    mapping(uint256 tokenId => string ImageUri) private s_tokenIdToUri;

    //////////////////////////////////////////////////////////
    //////////////////////  Functions  ///////////////////////
    //////////////////////////////////////////////////////////
    constructor() ERC721("Dogie", "DOG") {}

    function mintNft(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
    }

    /// URI - Uniform Resource Identifier
    /// A Uniform Resource Identifier (URI) is a string of characters that identifies a resource on the internet.
    /// URIs are used to identify web pages, files, and other resources.
    /// @dev tokenURI is almost simliar to api endpoint hosted somewhere, it will return the `metadata` for the NFT

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }
}
