# ERC721

-   ERC721, is a standard for non-fungible tokens (NFTs) on the Ethereum blockchain
-   Non-fungible refers to items that cannot be replaced with something else without changing the value of the original item.
-   One NFT != Other NFT
-   unlike ERC20, ERC721 cannot be divide into pieces

## Difference between ERC20 & ERC721

```sol
contract ERC20 {
    mapping(address user => uint256 amount) private s_balances;
}
```

-   In ERC20 mapping will hold each user and balanes

```sol
contract ERC721 {
    mapping(uint256 tokenId => address owner) private s_owners;
}
```

-   In ERC721 mapping will hold each unique token and who is the owner of it
