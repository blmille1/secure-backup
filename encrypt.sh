#!/bin/zsh

# Ensure a zip file name argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <name>"
  echo "e.g., $0 2024"
  exit 1
fi

# Define the source zip file and destination for encryption and hash
ZIP_NAME="$1"
ZIP_FILE="$HOME/TeraBox/$ZIP_NAME.zip"
ENCRYPTED_FILE="$HOME/TeraBox/$ZIP_NAME.zip.gpg"
HASH_FILE="$HOME/TeraBox/$ZIP_NAME.zip.gpg.sha256"

# Check if the specified zip file exists
if [ ! -f "$ZIP_FILE" ]; then
  echo "Error: File $ZIP_FILE not found."
  exit 1
fi

# Encrypt the ZIP file
echo "Encrypting $ZIP_FILE..."
gpg -c --no-symkey-cache --cipher-algo AES256 "$ZIP_FILE"

# Generate SHA-256 hash file for the encrypted file
echo "Generating SHA-256 hash for $ENCRYPTED_FILE..."
sha256sum "$ENCRYPTED_FILE" > "$HASH_FILE"

echo "Encryption and hash generation complete."
echo "Encrypted file: $ENCRYPTED_FILE"
echo "Hash file: $HASH_FILE"