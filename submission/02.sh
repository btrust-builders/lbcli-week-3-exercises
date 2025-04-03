# Create a native segwit address and get the public key from the address.
bitcoin-cli -regtest loadwallet "btrustwallet"
bitcoin-cli -regtest -rpcwallet=btrustwallet getnewaddress "" bech32

