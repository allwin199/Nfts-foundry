# ERC721

-   ERC721, is a standard for non-fungible tokens (NFTs) on the Ethereum blockchain
-   Non-fungible refers to items that cannot be replaced with something else without changing the value of the original item.
-   One NFT != Other NFT
-   unlike ERC20, ERC721 cannot be divide into pieces

## Difference between ERC20 & ERC721

-   In ERC20 mapping will hold each user and balanes

```sol
contract ERC20 {
    mapping(address user => uint256 amount) private s_balances;
}
```

-   In ERC721 mapping will hold each unique token and who is the owner of it

```sol
contract ERC721 {
    mapping(uint256 tokenId => address owner) private s_owners;
}
```

-   Addition to that ERC721 also contain a tokenURI()
-   Each NFT will have its own metadata
-   Using metadata, tokenURI will make each token to be unique

```
contract ERC721 {
    function tokenURI() {}
}
```

## Off chain Metadata

-   Get IPFS
-   Add Image to IPFS and get the hash
-   Add the Image hash in metadata and
-   Add metadata to IPFS and it will provide the tokenURI
-   Add tokenURI to the smart contract

## Chainlink

-   [Blog](https://chain.link/education/nfts#toc-first)
