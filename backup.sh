#!/bin/zsh

# Ensure both name and backup subfolder arguments are provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <name> <backup_subfolder>"
  echo "e.g., $0 2024 'My Pictures'"
  exit 1
fi

# Define variables
NAME="$1"
BACKUP_SUBFOLDER="$2"
ENCRYPTED_FILE="$HOME/TeraBox/$NAME.zip.gpg"
HASH_FILE="$HOME/TeraBox/$NAME.zip.gpg.sha256"
BACKUP_ROOT="$HOME/TeraBox/$BACKUP_SUBFOLDER"
BACKUP_DIR="$BACKUP_ROOT/$NAME"

# Check if the backup subfolder exists
if [ ! -d "$BACKUP_ROOT" ]; then
  echo "Error: Backup root folder $BACKUP_ROOT does not exist."
  exit 1
fi

# Create the specific backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Move the encrypted file parts and hash file to the backup directory
mv "$ENCRYPTED_FILE.part_"* "$HASH_FILE" "$BACKUP_DIR" 2>/dev/null

# Check if files were successfully moved
if [ $? -eq 0 ]; then
  echo "$NAME files moved to $BACKUP_DIR"
else
  echo "Error: Files not found or could not be moved."
fi