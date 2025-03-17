#!/bin/bash

# Bitcoin Transaction Mastery: Week 3 final exercise
# Multisignature and PSBT Workflow
# 
# This script implements a complete workflow for:
# 1. Creating a 2-of-3 multisig wallet using descriptor wallets
# 2. Properly importing and tracking multisig addresses
# 3. Creating transactions from multisig addresses using PSBTs
# 4. Simulating the signing process with multiple keys
# 5. Finalizing and broadcasting the transaction

# Ensure script fails on errors
set -e

# Configuration variables
NETWORK="regtest"
RPC_USER="" # TODO: replace with your username in bitcoin.conf
RPC_PASSWORD="" # TODO: replace with your password in bitcoin.conf
BITCOIN_CLI="bitcoin-cli -$NETWORK -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD"

# =====================================================================
# PART 1: HELPER FUNCTIONS
# =====================================================================

# Display error message and exit
function handle_error() {
  error_message="$1"
  echo "ERROR: $error_message"
  exit 1
}

# Create a descriptor wallet for multisig operations
function create_multisig_wallet() {
  wallet_name="$1"
  is_watchonly="${2:-false}"
  
  echo "Creating wallet: $wallet_name (watch-only: $is_watchonly)"
  
  # TODO: Implement wallet creation
  # Make sure to enable descriptors and set appropriate private key settings
  # HINT: if creating a watch-only wallet, ensure private keys are not included
}

# =====================================================================
# PART 2: MULTISIG SETUP
# =====================================================================

# Generate or import keys for the multisig
function setup_multisig_keys() {
  echo "Setting up multisig keys..."
  
  # TODO: Implement key setup
  # 1. Generate two internal keys using Bitcoin Core
  # 2. Use this external key for the multisig address (simulate a key from an external wallet)
        # external key: 02cf3ba76ff3c9e34311cb0afb9b40620667226e372e8745cf650ea8c891bdc04b
  # 3. Store pubkeys in variables
  
  PUBKEY1=
  PUBKEY2=
  PUBKEY3=02cf3ba76ff3c9e34311cb0afb9b40620667226e372e8745cf650ea8c891bdc04b
  
  echo "Using public keys:"
  echo "Key 1: $PUBKEY1"
  echo "Key 2: $PUBKEY2"
  echo "Key 3: $PUBKEY3 (external)"

  # Export the keys for other functions to use
  export PUBKEY1 PUBKEY2 PUBKEY3
  
  return 0
}

# Create a 2-of-3 multisig address
function create_multisig_address() {
  echo "Creating 2-of-3 multisig address..."
  
  # TODO: Implement multisig address creation
  # 1. Use the keys from setup_multisig_keys()
  # 2. Create a multisig address using the keys
  # 3. Store the address, redeemScript, and descriptor

  # HINT: for descrriptor wallets, you need to use the keys to create a descriptor first
  # then derive the address from the descriptor
  # Remember to get the descriptor checksum using getdescriptorinfo

  DESCRIPTOR=
  MULTISIG_ADDRESS=
  REDEEM_SCRIPT=

  # Export the address, redeemScript, and descriptor for other functions to use
  export MULTISIG_ADDRESS REDEEM_SCRIPT DESCRIPTOR
}

# Import the multisig address properly into a watchonly wallet
function import_multisig_to_wallet() {
  wallet_name="$1"
  descriptor="$2"
  
  echo "Importing multisig descriptor to $wallet_name..."
  
  # TODO: Implement descriptor import
  # 1. Create a proper importdescriptors request
  # 2. Import the descriptor to the wallet
  # 3. Verify the import was successful

  IMPORT_RESULT=
  IMPORT_SUCCESS=$(echo "$IMPORT_RESULT" | jq -r '.[0].success')
  
  if [ "$IMPORT_SUCCESS" != "true" ]; then
    IMPORT_ERROR=$(echo "$IMPORT_RESULT" | jq -r '.[0].error.message')
    handle_error "Failed to import descriptor: $IMPORT_ERROR"
  fi
  
  echo "Successfully imported multisig to wallet $wallet_name"
  
  # After importing, rescan the blockchain to find UTXOs
}

# =====================================================================
# PART 3: FUNDING AND TRACKING
# =====================================================================

# Fund the multisig address
function fund_multisig_address() {
  # Use the MULTISIG_ADDRESS variable from create_multisig_address
  amount="${1:-0.001}"  # Default to 0.001 BTC if no amount specified
  
  echo "Funding multisig address $MULTISIG_ADDRESS with $amount BTC..."
  
  # TODO: Implement funding
  # 1. Send funds to the multisig address
  # 2. Generate a block to confirm the transaction
  # 3. Return the funding txid

  FUNDING_TXID=
  echo "Funding transaction ID: $FUNDING_TXID"

  # Export the funding txid for other functions to use
  export FUNDING_TXID
}

# Verify the multisig address was funded
function verify_multisig_funding() {
  wallet_name="$1"
  
  echo "Verifying funding for address $MULTISIG_ADDRESS in wallet $wallet_name..."
  
  # TODO: Implement funding verification
  # 1. List unspent outputs for the address
  # 2. Return UTXO details for spending
  
  # HINT: use the watchonly wallet to check the UTXOs for the multisig address

  UTXO=
  UTXO_TXID=
  UTXO_VOUT=
  UTXO_AMOUNT=

  echo "UTXO details:"
  echo "UTXO: $UTXO"
  echo "TXID: $UTXO_TXID"
  echo "VOUT: $UTXO_VOUT"
  echo "AMOUNT: $UTXO_AMOUNT"

  # Export the UTXO details for other functions to use
  export UTXO UTXO_TXID UTXO_VOUT UTXO_AMOUNT
  
  return 0
}

# =====================================================================
# PART 4: PSBT CREATION AND SIGNING
# =====================================================================

# Create a PSBT to spend from the multisig
function create_multisig_psbt() {
  wallet_name="$1"
  utxo_txid="$2"
  utxo_vout="$3"
  destination_address="$4"
  amount="$5"
  
  echo "Creating PSBT to send $amount BTC to $destination_address..."
  
  # TODO: Implement PSBT creation
  # 1. Create a PSBT
  # 2. Update the PSBT with wallet data
  # 3. Return the PSBT

  PSBT=
  echo "PSBT created"

  # Export the PSBT for other functions to use
  export PSBT

  return 0
}

# Sign a PSBT with available keys
function sign_psbt() {
  wallet_name="$1"
  psbt="$2"
  
  echo "Signing PSBT with wallet $wallet_name..."
  
  # TODO: Implement PSBT signing
  # 1. Sign the PSBT with keys available in the wallet
  # 2. Return the updated PSBT

  # Sign the PSBT
  SIGN_RESULT=
  
  if [ $? -ne 0 ] || [ -z "$SIGN_RESULT" ]; then
    handle_error "Failed to sign PSBT with wallet $wallet_name"
    return 1
  fi
  
  # Extract the signed PSBT
  SIGNED_PSBT=
  
  if [ -z "$SIGNED_PSBT" ] || [ "$SIGNED_PSBT" = "null" ]; then
    handle_error "Invalid signing result: $SIGN_RESULT"
    return 1
  fi
  
  # Check if signing actually changed the PSBT
  if [ "$SIGNED_PSBT" = "$psbt" ]; then
    echo "Warning: PSBT did not change after signing. This wallet may not have the required keys."
  else
    echo "PSBT was successfully signed"
  fi
  
  echo "Signed PSBT: $SIGNED_PSBT"
  
  # Export the signed PSBT for other functions to use
  export SIGNED_PSBT
  
  return 0
}

# Analyze a PSBT to verify its status
function analyze_psbt() {
  psbt="$1"
  
  echo "Analyzing PSBT..."
  
  # TODO: Implement PSBT analysis
  # 1. Analyze the PSBT
  # 2. Check if the PSBT needs additional signatures
  # 3. Return an analysis of the PSBT status

  PSBT_STATUS=
  echo "PSBT status: $PSBT_STATUS"

  # Export the PSBT status for other functions to use
  export PSBT_STATUS
  
  return 0
}

# =====================================================================
# PART 5: FINALIZATION AND BROADCAST
# =====================================================================

# Finalize a PSBT
function finalize_psbt() {
  psbt="$1"
  
  echo "Finalizing PSBT..."
  
  # TODO: Implement PSBT finalization
  # 1. Finalize the PSBT
  # 2. Check if the PSBT is complete
  # 3. Return the final hex-encoded transaction

  FINALIZED_PSBT=
  if [ $? -ne 0 ] || [ -z "$FINALIZE_RESULT" ]; then
    handle_error "Failed to finalize PSBT"
    return 1
  fi

  # Check if the PSBT is complete
  COMPLETE=
  if [ "$COMPLETE" != "true" ]; then
    handle_error "PSBT is not complete. Cannot finalize."
    return 1
  fi

  # Extract the final hex-encoded transaction
  HEX_TX=
  if [ -z "$HEX_TX" ] || [ "$HEX_TX" = "null" ]; then
    handle_error "Invalid finalization result: $FINALIZE_RESULT"
    return 1
  fi

  # Export the finalized PSBT for other functions to use
  echo "PSBT has been finalized to a complete transaction"
  echo "Final hex-encoded transaction: $HEX_TX"

  export HEX_TX

  return 0
}

# Broadcast a transaction
function broadcast_transaction() {
  hex_tx="$1"
  
  echo "Broadcasting transaction..."
  
  # TODO: Implement transaction broadcast
  # 1. Broadcast the transaction
  # 2. Return the transaction ID
  # 3. Generate a block to confirm the transaction

  # Broadcast the transaction
  TXID=
  
  if [ $? -ne 0 ] || [ -z "$TXID" ]; then
    handle_error "Failed to broadcast transaction"
    return 1
  fi
  
  echo "Transaction successfully broadcast!"
  echo "Transaction ID: $TXID"
  
  # Export the transaction ID for other functions to use
  export TRANSACTION_ID="$TXID"
  
  echo "Generating a block to confirm the transaction..."
  MINING_ADDRESS=
  # TODO: Generate a block to confirm the transaction
  BLOCK_HASH=
  echo "Block hash: $BLOCK_HASH"
  
  echo "Transaction has been confirmed in a new block"
  
  return 0
}

# =====================================================================
# MAIN WORKFLOW
# =====================================================================

function run_multisig_workflow() {
  echo "==================================================="
  echo "Week 3: Bitcoin PSBT Multisig Workflow"
  echo "==================================================="
  
  # 1. Create wallets
  create_multisig_wallet "multisig_wallet"
  create_multisig_wallet "watchonly_wallet" true # Create a watch-only wallet
  create_multisig_wallet "key_wallet" false  # This wallet needs private keys
  create_multisig_wallet "funding_wallet" false  # This wallet doesn't need to be a descriptor wallet
  
  #2. Ensure funding wallet has coins
  echo "Ensuring funding wallet has coins..."
  FUNDING_BALANCE=$($BITCOIN_CLI -rpcwallet=funding_wallet getbalance)
  echo "Initial funding wallet balance: $FUNDING_BALANCE BTC"
  
  # Always generate blocks to ensure sufficient balance since we are using regtest mode
  echo "Generating blocks to ensure sufficient funding..."
  MINING_ADDRESS=$($BITCOIN_CLI -rpcwallet=funding_wallet getnewaddress)
  $BITCOIN_CLI generatetoaddress 101 "$MINING_ADDRESS" > /dev/null
  FUNDING_BALANCE=$($BITCOIN_CLI -rpcwallet=funding_wallet getbalance)
  echo "New funding wallet balance: $FUNDING_BALANCE BTC"

  # 3. Set up multisig
  setup_multisig_keys
  create_multisig_address
  
  # 4. Import and fund multisig
  echo "Importing multisig to watchonly wallet..."
  import_multisig_to_wallet "watchonly_wallet" "$DESCRIPTOR"

  # 5. Fund the multisig address
  echo "Funding the multisig address..."
  # Get the current balance and use 50% of it for funding
  FUNDING_BALANCE=$($BITCOIN_CLI -rpcwallet=funding_wallet getbalance)
  FUNDING_AMOUNT=$(echo "$FUNDING_BALANCE * 0.5" | bc | awk '{printf "%.8f", $0}')
  echo "Using $FUNDING_AMOUNT BTC (50% of available $FUNDING_BALANCE BTC) for funding"
  fund_multisig_address "$FUNDING_AMOUNT"
    # 6. Verify funding and retrieve UTXO details
  echo "Verifying funding of multisig address..."
  verify_multisig_funding
  
  # Check that we have valid UTXO information
  if [ -z "$UTXO_TXID" ] || [ -z "$UTXO_VOUT" ] || [ -z "$UTXO_AMOUNT" ]; then
    handle_error "Missing UTXO information. Cannot proceed with PSBT creation."
  fi
  
  # 7. Create a destination address
  echo "Creating destination address for the transaction..."
  DESTINATION_ADDRESS=$($BITCOIN_CLI -rpcwallet=funding_wallet getnewaddress)
  echo "Destination address: $DESTINATION_ADDRESS"
  
  # 8. Create PSBT to spend from multisig
  echo "Creating PSBT to spend from multisig address..."
  # Use the full UTXO amount and let the fee be subtracted from the output
  create_multisig_psbt "watchonly_wallet" "$UTXO_TXID" "$UTXO_VOUT" "$DESTINATION_ADDRESS" "$UTXO_AMOUNT"
  
  # 9. Analyze the PSBT to check what's needed
  echo "Analyzing the PSBT..."
  analyze_psbt "$PSBT"
  
  # 10. Sign the PSBT with the key wallet (one of the required signatures)
  echo "Signing PSBT with key wallet..."
  sign_psbt "key_wallet" "$PSBT"
  
  # 11. Finalize the PSBT
  echo "Finalizing the PSBT..."
  finalize_psbt "$SIGNED_PSBT"
  
  # 12. Broadcast the transaction
  echo "Broadcasting the transaction..."
  broadcast_transaction "$HEX_TX"
  
  echo "==============================================="
  echo "Multisig workflow completed successfully!"
  echo "Transaction ID: $TRANSACTION_ID"
  echo "==============================================="
  
  # Show some information about real-world multisig process
  echo "In a real-world scenario, the process would be:"
  echo "1. The coordinator creates a PSBT for a multisig transaction"
  echo "2. The PSBT is exported (e.g., as a file or QR code)" 
  echo "3. Each co-signer imports the PSBT, signs it with their key, and exports it again"
  echo "4. The coordinator collects all the signatures, finalizes the PSBT, and broadcasts it"
  echo "==============================================="
}

# Execute the workflow
run_multisig_workflow 