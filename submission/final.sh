#!/bin/bash
set -e

# ========================================================================
# WEEK 3 CAPSTONE: BITCOIN TREASURY MULTISIG CHALLENGE
# ========================================================================
#
# Scenario: You are setting up a shared Bitcoin treasury for a small team.
# The treasury requires multiple signatures to spend funds (multisig).
# You will use PSBTs to coordinate signing between team members.
#
# Concepts covered:
#   - Wallet creation
#   - SegWit address generation and public key extraction
#   - P2SH multisig address creation (2-of-4)
#   - Funding and verifying a multisig address
#   - Building a raw transaction from a multisig UTXO
#   - Converting to PSBT for multi-party signing
#   - Decoding and inspecting a PSBT
#
# ========================================================================

check_cmd() {
  if [ $? -ne 0 ]; then
    echo "❌ Error: $1 failed!"
    exit 1
  fi
}

echo "========================================================"
echo "🏦 WEEK 3: BITCOIN TREASURY MULTISIG CHALLENGE 🏦"
echo "========================================================"
echo ""
echo "Setting up a shared Bitcoin treasury for a small team."
echo "We'll use multisig for team approvals and PSBT for"
echo "transaction coordination."
echo ""

# ========================================================================
# CHALLENGE 1: Create Treasury Wallet
# ========================================================================
# Create a wallet named "builderswallet" to manage the team treasury.
# Handle the case where the wallet already exists gracefully.
echo "CHALLENGE 1: Create Treasury Wallet"
echo "-----------------------------------"
# STUDENT TASK: Create a wallet named "builderswallet"
# HINT: Use bitcoin-cli -regtest createwallet
# HINT: Handle wallet already exists error with 2>/dev/null || true
# WRITE YOUR SOLUTION BELOW:


echo "✅ Wallet 'builderswallet' is ready"

# ========================================================================
# CHALLENGE 2: Mine Initial Blocks
# ========================================================================
# Mine 101 blocks so the wallet has spendable coins.
# Remember: coinbase rewards need 100 confirmations before spending.
echo ""
echo "CHALLENGE 2: Mine Initial Blocks"
echo "--------------------------------"
echo "Mining 101 blocks to get spendable coins..."
# STUDENT TASK: Generate a new bech32 address from builderswallet
# then mine 101 blocks to it. Suppress the block hash output.
# HINT: Use getnewaddress "" bech32 and generatetoaddress 101
# WRITE YOUR SOLUTION BELOW:


echo "✅ 101 blocks mined"
# STUDENT TASK: Get and display the wallet balance
# WRITE YOUR SOLUTION BELOW:


# ========================================================================
# CHALLENGE 3: Generate Team Member Keys
# ========================================================================
# Each team member needs a SegWit address and public key.
# These public keys will be used to create the multisig address.
echo ""
echo "CHALLENGE 3: Generate Team Member Keys"
echo "--------------------------------------"
echo "Creating 4 SegWit addresses and extracting public keys..."
# STUDENT TASK: Generate 4 bech32 addresses from builderswallet
# and extract the public key from each using getaddressinfo.
# Store the public keys in an array called PUBKEYS.
# Print each pubkey with its member number.
# HINT: Use a for loop, getnewaddress "" bech32, getaddressinfo, jq -r '.pubkey'
# WRITE YOUR SOLUTION BELOW:


echo "✅ 4 public keys collected"

# ========================================================================
# CHALLENGE 4: Create 2-of-4 Multisig Address
# ========================================================================
# Combine the 4 public keys into a multisig address.
# Any 2 of the 4 team members can authorize spending.
echo ""
echo "CHALLENGE 4: Create 2-of-4 Multisig Address"
echo "------------------------------------------"
echo "Creating a P2SH multisig address requiring 2 of 4 signatures..."
# STUDENT TASK: Create a 2-of-4 P2SH multisig address using createmultisig.
# Extract and store: MULTISIG_ADDR and REDEEM_SCRIPT
# HINT: Use createmultisig 2 with the PUBKEYS array
# HINT: Use jq -r '.address' and jq -r '.redeemScript'
# WRITE YOUR SOLUTION BELOW:


echo "  Multisig Address: $MULTISIG_ADDR"
echo "  Redeem Script:    $REDEEM_SCRIPT"
echo "✅ 2-of-4 multisig address created"

# ========================================================================
# CHALLENGE 5: Fund the Treasury
# ========================================================================
# Send bitcoin to the multisig address to fund the team treasury.
echo ""
echo "CHALLENGE 5: Fund the Treasury"
echo "-----------------------------"
echo "Sending 0.50 BTC to the multisig treasury..."
# STUDENT TASK: Send 0.50 BTC from builderswallet to the multisig address.
# Store the transaction ID in TXID.
# HINT: Use sendtoaddress with -rpcwallet=builderswallet
# WRITE YOUR SOLUTION BELOW:


echo "  Funding TXID: $TXID"
echo "✅ Treasury funded!"

# ========================================================================
# CHALLENGE 6: Confirm Transaction
# ========================================================================
# Mine a block to confirm the funding transaction.
echo ""
echo "CHALLENGE 6: Confirm Transaction"
echo "--------------------------------"
# STUDENT TASK: Mine 1 block to confirm the funding transaction.
# Suppress the block hash output with > /dev/null
# WRITE YOUR SOLUTION BELOW:


echo "✅ 1 block mined — funding confirmed"

# ========================================================================
# CHALLENGE 7: Verify Funds with scantxoutset
# ========================================================================
# Use scantxoutset to confirm funds arrived at the multisig address.
# Note: scantxoutset works for any address, even ones not in your wallet.
echo ""
echo "CHALLENGE 7: Verify Funds with scantxoutset"
echo "-----------------------------------------"
echo "Scanning UTXO set to confirm funds arrived..."
# STUDENT TASK: Use scantxoutset to scan for UTXOs at MULTISIG_ADDR.
# Extract the total_amount and store in FUNDS_BTC.
# Check that the balance is greater than 0.
# HINT: Use scantxoutset start with addr() descriptor
# HINT: Use jq -r '.total_amount'
# WRITE YOUR SOLUTION BELOW:


echo "  Treasury Balance: $FUNDS_BTC BTC"
echo "✅ Funds confirmed at multisig address!"

# ========================================================================
# CHALLENGE 8: Create Raw Spending Transaction
# ========================================================================
# Build a raw transaction that spends from the multisig UTXO.
# Use scantxoutset to find the UTXO details (txid, vout, amount).
echo ""
echo "CHALLENGE 8: Create Raw Spending Transaction"
echo "------------------------------------------"
echo "Creating a transaction to spend from the multisig..."
# STUDENT TASK: Use scantxoutset to get the UTXO details:
#   - UTXO_TXID from .unspents[0].txid
#   - UTXO_VOUT from .unspents[0].vout
#   - UTXO_VALUE from .unspents[0].amount
# Generate a new bech32 destination address (DEST_ADDR).
# Calculate SPEND_BTC = UTXO_VALUE - 0.001 (fee).
# Create a raw transaction using createrawtransaction.
# Store the hex in SPEND_TX.
# HINT: Make sure SPEND_BTC has a leading zero (use sed 's/^\./0./')
# WRITE YOUR SOLUTION BELOW:


echo "  TXID: $UTXO_TXID"
echo "  Vout: $UTXO_VOUT"
echo "  UTXO value: $UTXO_VALUE BTC"
echo "  Destination: $DEST_ADDR"
echo "✅ Raw transaction created (value: $SPEND_BTC BTC, fee: 0.001 BTC)"

# ========================================================================
# CHALLENGE 9: Convert to PSBT
# ========================================================================
# Convert the raw transaction to a PSBT so team members can sign it.
# PSBTs are the standard format for passing partially signed transactions
# between multiple signers or hardware wallets.
echo ""
echo "CHALLENGE 9: Convert to PSBT"
echo "---------------------------"
echo "Converting raw tx to Partially Signed Bitcoin Transaction..."
# STUDENT TASK: Convert SPEND_TX to a PSBT using converttopsbt.
# Store the result in PSBT.
# Print the first 64 characters of the PSBT followed by "..."
# WRITE YOUR SOLUTION BELOW:


echo "✅ PSBT created — needs 2 team signatures to broadcast"

# ========================================================================
# CHALLENGE 10: Decode PSBT
# ========================================================================
# Decode the PSBT to inspect the transaction details.
# Extract: txid, output value in BTC and satoshis, receiver address.
echo ""
echo "CHALLENGE 10: Decode PSBT"
echo "-------------------------"
echo "Decoding PSBT to extract transaction details..."
# STUDENT TASK: Decode PSBT using decodepsbt.
# Extract:
#   - PSBT_TXID from .tx.txid
#   - PSBT_OUT_VALUE from .tx.vout[0].value
#   - PSBT_OUT_SATS (convert BTC to satoshis)
#   - PSBT_OUT_ADDR from .tx.vout[0].scriptPubKey.address
# WRITE YOUR SOLUTION BELOW:


echo "  TXID:            $PSBT_TXID"
echo "  Output Amount:   $PSBT_OUT_VALUE BTC ($PSBT_OUT_SATS sats)"
echo "  Receiver:        $PSBT_OUT_ADDR"
echo "✅ PSBT decoded successfully"

# ========================================================================
# SUCCESS SUMMARY
# ========================================================================
echo ""
echo "========================================================"
echo "🏆 TREASURY SETUP COMPLETE - SUCCESS SUMMARY 🏆"
echo "========================================================"
echo ""
echo "  Wallet:             builderswallet"
echo "  Multisig Address:   $MULTISIG_ADDR"
echo "  Threshold:          2 of 4 signatures"
echo "  Treasury Balance:   $FUNDS_BTC BTC"
echo "  Funding TXID:       $TXID"
echo "  Spending PSBT TXID: $PSBT_TXID"
echo "  Payment Amount:     $PSBT_OUT_VALUE BTC ($PSBT_OUT_SATS sats)"
echo "  Payment To:         $PSBT_OUT_ADDR"
echo ""
echo "✅ All challenges complete! The PSBT needs 2 of 4 team"
echo "   signatures before it can be broadcast to the network."