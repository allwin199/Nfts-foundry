# Foundry NFT

This Repo contains 2 different kinds of NFTs.

1. An IPFS Hosted NFT
2. An SVG NFT (Hosted 100% on-chain)

<br/>
<p align="center">
<img src="./images/pug.png" width="225" alt="NFT Pug">
<img src="./images/happy.svg" width="225" alt="NFT Happy">
<img src="./images/sad.svg" width="225" alt="NFT Frown">
</p>
<br/>

# Getting Started

## Quickstart

```sh
git clone https://github.com/allwin199/foundry-Nfts-v3.git
cd foundry-Nfts-v3
forge build
```

# Usage

## Start a local node

```sh
make anvil
```

## Deploy to Anvil

### IPFS hosted NFT

This will default to your local node. You need to have it running in another terminal in order for it to deploy.

```sh
make deployBasicNftToAnvil
```

-   To Mint an NFT

```sh
make mintBasicNftOnAnvil
```

### On Chain NFT

```sh
make deployMoodNftToAnvil
```

-   To Mint an NFT

```sh
make mintMoodNftOnAnvil
```

# Deployment to a testnet or mainnet

1. Setup environment variables

-   You'll want to set your `SEPOLIA_RPC_URL` in environment variables. You can add them to a `.env` file, similar to what you see in `.env.example`.

-   `SEPOLIA_RPC_URL`: This is url of the sepolia testnet node you're working with. You can get setup with one for free from [Alchemy](https://alchemy.com/?a=673c802981)

2. Use wallet options to Encrypt Private Keys

-   [Private Key Encryption](https://github.com/allwin199/foundry-fundamendals/blob/main/DeploymentDetails.md)

Optionally, add your `ETHERSCAN_API_KEY` if you want to verify your contract on [Etherscan](https://etherscan.io/).

1. Get testnet ETH

Head over to [faucets.chain.link](https://faucets.chain.link/) and get some testnet ETH. You should see the ETH show up in your metamask.

2. Deploy

### IPFS hosted NFT

```sh
make deployBasicNftToSepolia
```

-   To Interact with it

```sh
make mintBasicNftOnAnvil
```

### On Chain NFT

```sh
make deployMoodNftToSepolia
```

-   To Interact with it

```sh
make mintMoodNftOnSepolia
```

---

## Testing

1. Unit
2. Integration
3. Forked

```sh
forge test
```

or

```sh
forge test --fork-url $SEPOLIA_RPC_URL
```

### Test Coverage

```sh
forge coverage
```

```sh
forge coverage --report debug > coverage.txt
```

-   To generate lcov report

```sh
make generateTestReport
```

## Estimate gas

You can estimate how much gas things cost by running:

```sh
forge snapshot
```

And you'll see an output file called `.gas-snapshot`

# Formatting

To run code formatting:

```sh
forge fmt
```

# Thank you!
