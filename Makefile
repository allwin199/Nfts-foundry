-include .env

.PHONY: deployToAnvil deployToSepolia generateTestReport
# .phoney describes all the command are not directories

# Including @ will not display the acutal command in terminal
# The backslash (\) is used as a line continuation 

deployToAnvil:
	@forge script script/DeployBasicNft.s.sol:DeployBasicNft --rpc-url $(ANVIL_RPC_URL) --account $(ACCOUNT_FOR_ANVIL) --sender $(ANVIL_KEYCHAIN) --broadcast

deployToSepolia:
	@forge script script/DeployBasicNft.s.sol:DeployBasicNft --rpc-url $(SEPOLIA_RPC_URL) --account $(ACCOUNT_FOR_SEPOLIA) --sender $(SEPOLIA_KEYCHAIN) --broadcast --verify $(ETHERSCAN_API_KEY)

mintNftOnAnvil:
	@forge script script/Interactions.s.sol:MintBasicNft --rpc-url $(ANVIL_RPC_URL) --account $(ACCOUNT_FOR_ANVIL) --sender $(ANVIL_KEYCHAIN) --broadcast

mintNftOnSepolia:
	@forge script script/Interactions.s.sol:MintBasicNft --rpc-url $(SEPOLIA_RPC_URL) --account $(ACCOUNT_FOR_SEPOLIA) --sender $(SEPOLIA_KEYCHAIN) --broadcast

generateTestReport :;
	@rm -rf coverage; \
	forge coverage --report lcov; \
	genhtml lcov.info --output-directory coverage; \
	open coverage/index.html; \