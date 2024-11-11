#!/bin/zsh

# Ensure a gpg file name argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <name>"
  echo "e.g.,: $0 2024"
  exit 1
fi

NAME="$1"
ENCRYPTED_FILE="$HOME/TeraBox/$NAME.zip.gpg"
HASH_FILE="$HOME/TeraBox/$NAME.zip.gpg.sha256"

# Check if the specified file exists
if [ ! -f "$ENCRYPTED_FILE" ]; then
  echo "Error: File $ENCRYPTED_FILE not found."
  exit 1
fi

echo "Splitting $ENCRYPTED_FILE into 100 MB chunks..."

split -a 3 -db 100M "$ENCRYPTED_FILE" "$ENCRYPTED_FILE.part_"