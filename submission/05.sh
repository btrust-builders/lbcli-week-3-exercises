# Create a partially signed transaction from the details below

# Amount of 20,000,000 satoshis to this address: 2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP 
# Use the UTXOs from the transaction below
# transaction="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"

#!/bin/bash

# Ensure Bitcoin Core is running
bitcoin-cli -regtest stop
bitcoind -regtest -daemon
sleep 5  # Give it time to start

# Wallet name
WALLET_NAME="btrustwallet"

# Check if wallet exists, otherwise create it
if ! bitcoin-cli -regtest listwallets | grep -q "$WALLET_NAME"; then
    bitcoin-cli -regtest createwallet "$WALLET_NAME"
fi

# Load wallet if not already loaded
if ! bitcoin-cli -regtest listwallets | grep -q "$WALLET_NAME"; then
    bitcoin-cli -regtest loadwallet "$WALLET_NAME"
fi

# Check wallet balance
BALANCE=$(bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" getbalance)
if (( $(echo "$BALANCE < 0.5" | bc -l) )); then
    echo "⚠️  Insufficient funds! Mining blocks and funding wallet..."
    bitcoin-cli -regtest generatetoaddress 101 "$(bitcoin-cli -regtest getnewaddress)"
    RECEIVER=$(bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" getnewaddress)
    bitcoin-cli -regtest sendtoaddress "$RECEIVER" 1
    bitcoin-cli -regtest generatetoaddress 1 "$(bitcoin-cli -regtest getnewaddress)"
fi

# Transaction details
txid="c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef77"
vout=37
destination_address="2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP"
amount_satoshis=20000000  # 20 million satoshis = 0.2 BTC

# Create raw transaction
rawtx=$(bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" createrawtransaction \
    '[{"txid": "'"$txid"'", "vout": '"$vout"'}]' \
    '[{"'"$destination_address"'": 0.2}]')

echo "Raw Transaction: $rawtx"

# Create PSBT
psbt=$(bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" walletcreatefundedpsbt \
    '[{"txid": "'"$txid"'", "vout": '"$vout"'}]' \
    '[{"'"$destination_address"'": 0.2}]' \
    0 '{"fee_rate": 10}')

echo "Partially Signed Transaction: $psbt"
