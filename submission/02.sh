# Create a native segwit address and get the public key from the address.
# submission/02.sh
PUB_KEY=$(bitcoin-cli -regtest -rpcwallet=btrustwallet getnewaddress "" bech32)
echo $PUB_KEY


