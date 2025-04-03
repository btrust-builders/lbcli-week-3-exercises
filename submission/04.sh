# Create a 2-of-3 P2SH multisig address from the public keys below:

# 024bc198a88b69316952414af34105613c3617561a433a229100a0966cd631dd3d
# 035e11024a7fa1e0ca537e0e76b15c1631486f6611c7d8187aea8f6c1ae5d30617
# 03ce11c7b563c3d7fae916351f234eac5089ad2e42fa9e29a94ee944e00c880c66
#!/bin/bash

# Define public keys
zpublic1="024bc198a88b69316952414af34105613c3617561a433a229100a0966cd631dd3d"
zpublic2="035e11024a7fa1e0ca537e0e76b15c1631486f6611c7d8187aea8f6c1ae5d30617"
zpublic3="03ce11c7b563c3d7fae916351f234eac5089ad2e42fa9e29a94ee944e00c880c66"

# Generate P2SH multisig address
MULTISIG_OUTPUT=$(bitcoin-cli -regtest createmultisig 2 "[\"$zpublic1\", \"$zpublic2\", \"$zpublic3\"]")

# Extract only the address from the JSON output
P2SH_ADDRESS=$(echo "$MULTISIG_OUTPUT" | jq -r '.address')

# Output the address
echo "$P2SH_ADDRESS"


