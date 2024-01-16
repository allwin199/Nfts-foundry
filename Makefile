-include .env

.PHONY: deployToAnvil deployToSepolia generateTestReport
# .phoney describes all the command are not directories

# Including @ will not display the acutal command in terminal
# The backslash (\) is used as a line continuation 

deployBasicNftToAnvil:
	@forge script script/DeployBasicNft.s.sol:DeployBasicNft --rpc-url $(ANVIL_RPC_URL) --account $(ACCOUNT_FOR_ANVIL) --sender $(ANVIL_KEYCHAIN) --broadcast

deployBasicNftToSepolia:
	@forge script script/DeployBasicNft.s.sol:DeployBasicNft --rpc-url $(SEPOLIA_RPC_URL) --account $(ACCOUNT_FOR_SEPOLIA) --sender $(SEPOLIA_KEYCHAIN) --broadcast --verify $(ETHERSCAN_API_KEY)

mintBasicNftOnAnvil:
	@forge script script/Interactions.s.sol:MintBasicNft --rpc-url $(ANVIL_RPC_URL) --account $(ACCOUNT_FOR_ANVIL) --sender $(ANVIL_KEYCHAIN) --broadcast

mintBasicNftOnSepolia:
	@forge script script/Interactions.s.sol:MintBasicNft --rpc-url $(SEPOLIA_RPC_URL) --account $(ACCOUNT_FOR_SEPOLIA) --sender $(SEPOLIA_KEYCHAIN) --broadcast

deployMoodNftToAnvil:
	@forge script script/DeployMoodNft.s.sol:DeployMoodNft --rpc-url $(ANVIL_RPC_URL) --account $(ACCOUNT_FOR_ANVIL) --sender $(ANVIL_KEYCHAIN) --broadcast

deployMoodNftToSepolia:
	@forge script script/DeployMoodNft.s.sol:DeployMoodNft --rpc-url $(SEPOLIA_RPC_URL) --account $(ACCOUNT_FOR_SEPOLIA) --sender $(SEPOLIA_KEYCHAIN) --broadcast --verify $(ETHERSCAN_API_KEY)

mintMoodNftOnAnvil:
	@forge script script/Interactions.s.sol:MintMoodNft --rpc-url $(ANVIL_RPC_URL) --account $(ACCOUNT_FOR_ANVIL) --sender $(ANVIL_KEYCHAIN) --broadcast

mintMoodNftOnSepolia:
	@forge script script/Interactions.s.sol:MintMoodNft --rpc-url $(SEPOLIA_RPC_URL) --account $(ACCOUNT_FOR_SEPOLIA) --sender $(SEPOLIA_KEYCHAIN) --broadcast

flipMoodOnAnvil:
	@forge script script/Interactions.s.sol:flipMood --rpc-url $(ANVIL_RPC_URL) --account $(ACCOUNT_FOR_ANVIL) --sender $(ANVIL_KEYCHAIN) --broadcast

flipMoodOnSepolia:
	@forge script script/Interactions.s.sol:flipMood --rpc-url $(SEPOLIA_RPC_URL) --account $(ACCOUNT_FOR_SEPOLIA) --sender $(SEPOLIA_KEYCHAIN) --broadcast

generateTestReport :;
	@rm -rf coverage; \
	forge coverage --report lcov; \
	genhtml lcov.info --output-directory coverage; \
	open coverage/index.html; \