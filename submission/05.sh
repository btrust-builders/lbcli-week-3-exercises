# Create a partially signed transaction from the details below

# Amount of 20,000,000 satoshis to this address: 2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP 
# Use the UTXOs from the transaction below
# transaction="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"

#!/bin/bash

# Enable fallbackfee in bitcoin.conf
echo "fallbackfee=0.0002" >> ~/.bitcoin/bitcoin.conf

# Restart Bitcoin Core to apply changes
bitcoin-cli -regtest stop
bitcoind -regtest -daemon
sleep 5  # Give it time to restart

# Transaction details
txid="77efbd235f00d1d92c77e3e4b2a5f6d9954547d0865f8d695eecbbde8e92b0c8"
vout=37

# Create raw transaction
rawtx=$(bitcoin-cli -regtest createrawtransaction '[{"txid": "'"$txid"'", "vout": '"$vout"'}]' '[{"2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP": 0.20}, {"bcrt1qlpy0u5n8fydg5hfjgg77fv9zf5gxt3srrykua5": 0.03679108}]')
echo "Raw Transaction: $rawtx"

# Create partially signed Bitcoin transaction (PSBT) with fee rate
psbt=$(bitcoin-cli -regtest walletcreatefundedpsbt '[]' '[{"2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP": 0.20}, {"bcrt1qlpy0u5n8fydg5hfjgg77fv9zf5gxt3srrykua5": 0.03679108}]' 0 '{"fee_rate": 10}')
echo "Partially Signed Transaction: $psbt"
