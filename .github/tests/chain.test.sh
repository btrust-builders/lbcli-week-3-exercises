#!/bin/bash

echo "Running Chain Test..."
chmod +x submission/02.sh
CHAIN=$(submission/02.sh)
echo "Bitcoin chain: $CHAIN"

if [[ "$CHAIN" == "regtest" ]]; then
  echo "✅ Chain verification passed!"
  exit 0
else
  echo "❌ Chain verification failed!"
  exit 1
fi 
