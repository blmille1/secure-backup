#!/bin/zsh

# Ensure a source directory argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <source_directory>"
  exit 1
fi

# Get the source directory from the argument and strip trailing slashes
SOURCE="${1%/}"

# Extract the name of the folder for the ZIP file
FOLDER_NAME=$(basename "$SOURCE")

# Define the destination directory and zip file name
DEST_DIR="$HOME/TeraBox"
ZIP_FILE="$DEST_DIR/$FOLDER_NAME.zip"

# Create the TeraBox folder if it doesn't exist
mkdir -p "$DEST_DIR"

# Compress the source folder into a ZIP file
echo "Creating ZIP file: $ZIP_FILE from $SOURCE..."
zip -9 -r "$ZIP_FILE" "$SOURCE"

echo "ZIP file created at $ZIP_FILE"