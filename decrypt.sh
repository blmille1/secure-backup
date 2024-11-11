#!/bin/zsh

# Ensure a zip file name argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <name>"
  echo "e.g., $0 2024"
  echo "e.g., $0 2024-reconstructed"
  exit 1
fi

NAME="$1"
ZIP_FILE="$HOME/TeraBox/$NAME.zip"
ENCRYPTED_FILE="$HOME/TeraBox/$NAME.zip.gpg"
HASH_FILE="$HOME/TeraBox/$NAME.zip.gpg.sha256"

if [ ! -f "$ENCRYPTED_FILE" ]; then
  echo "Error: File $ENCRYPTED_FILE not found."
  exit 1
fi

echo "Decrypting $ENCRYPTED_FILE..."
gpg "$ENCRYPTED_FILE"

if [ ! -f "$ZIP_FILE" ]; then
  echo "Error: File $ZIP_FILE not found. Decryption unsuccessful."
  exit 1
fi

echo "Decryption of file $ZIP_FILE was successful."