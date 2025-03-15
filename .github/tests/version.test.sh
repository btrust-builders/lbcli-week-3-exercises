#!/bin/bash

echo "Running Bitcoin Version Test..."
BITCOIN_VERSION=$(submission/01.sh)
echo "Bitcoin CLI Version: $BITCOIN_VERSION"

if [[ $BITCOIN_VERSION == *"28"* ]]; then
  echo "✅ Success: Bitcoin CLI version"
  exit 0
else
  echo "❌ Error: Bitcoin CLI version failed"
  exit 1
fi 
