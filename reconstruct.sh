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
RECONSTRUCTED_FILE="$HOME/TeraBox/$NAME-reconstructed.zip.gpg"
RECONSTRUCTED_HASH_FILE="$RECONSTRUCTED_FILE.sha256"

cat "$ENCRYPTED_FILE.part_"* > "$RECONSTRUCTED_FILE"
echo "Reconstructed file $RECONSTRUCTED_FILE"
# Check the file hashes to ensure they are identical
sha256sum "$RECONSTRUCTED_FILE" > "$RECONSTRUCTED_HASH_FILE"
echo "Generated sha256 hash file $RECONSTRUCTED_HASH_FILE"

ORIGINAL_HASH=$(cut -d ' ' -f 1 $HASH_FILE)
RECONSTRUCTED_HASH=$(cut -d ' ' -f 1 $RECONSTRUCTED_HASH_FILE)

echo "$ORIGINAL_HASH - Original Hash"
echo "$RECONSTRUCTED_HASH - Reconstructed Hash"

[[ "$ORIGINAL_HASH" == "$RECONSTRUCTED_HASH" ]] && echo "Reconstruction successful. Hashes match." || echo "Reconstruction unsuccessful. Hashes don't match!"

