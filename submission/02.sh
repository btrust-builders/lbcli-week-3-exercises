# Create a native segwit address and get the public key from the address.
# submission/02.sh
#!/bin/bash

# Generate a new bech32 (SegWit) address
ADDRESS=$(bitcoin-cli -regtest -rpcwallet=btrustwallet getnewaddress "" bech32)

# Get the public key associated with the address
PUB_KEY=$(bitcoin-cli -regtest -rpcwallet=btrustwallet getaddressinfo "$ADDRESS" | jq -r '.pubkey')

# Output the public key
echo "$PUB_KEY"


