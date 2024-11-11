# Overview
1. TeraBox offers 1 TB free online storage
2. I don't trust TeraBox, so I encrypt all my files client-side (before I upload)
3. Their reliability on uploading large files is terrible, so we split them into 100 MB chunks
4. They have an automatic backup feature for certain folders, so it retries on failure and automatically uploads new files or on file changes
5. I've chosen `~/TeraBox` to be the working folder
6. `~/TeraBox` is not backed up to TeraBox directly
7. In my TeraBox MacOS App, I have `~/TeraBox/My Pictures` backing up to `My Pictures` in the cloud
    - NOTE: TeraBox duplicates the folder name you're backing up, so I chose the TeraBox root.  I originally mapped the local `My Pictures` to `My Pictures` on TeraBox and it created `My Pictures/My Pictures`, which isn't what I wanted.

# Environment
I'm running on a MacBook Air M1, but I don't think that matters.  All of this should be able to be at least adapted for other OSes.

# Command-Line Tools
- zsh
- gpg
- zip
- split
- cat
- sha256sum
- cut

# Tips
- You can get perks by playing games in the Phone App which extend to Application installs, too, though I haven't found a way to play them on the desktop app
- Gold Miner, I think, is the most efficient way of getting perks
    - Focus on getting the big Gold chunk at the bottom.  It has a chance of giving you days of Premium service, which removes some of the limitations
    - It's pretty easy and I find it a fun game to play and it only takes 60 seconds per game
- I installed the App before I had Premium features and am wondering if that had a big negative impact in certain ways.
- I had a lot of failed uploads just uploading unencrypted zip files.  Was it getting nosy and failing to upload more reliably?  I don't know.  It was horrible until I started encrypting the files.  But maybe it was in a weird transition state between free and Ultimate (still free via playing the games).

# Workflow Example
- I inserted an external backup drive which mounted to `/Volumes/Primary SSD/`
- I decided to back up my pictures by year because I wanted to chunk my backups so that if one file in one of the chunks got corrupted, I could still recover other images.

`Prepare original files (declutter, etc., dupeGuru for file deduplication)` --> `Zip` --> `Encrypt` --> `Chunk (100 MB)` --> `Test it (reconstruct from parts, decrypt, verify)` --> `Backup parts and sha256 hash to TeraBox`

```bash
# The scripts expect to work out of ~/TeraBox
mkdir ~/TeraBox

# Prepare your folder for backup.  I use dupeGuru to remove duplicated files/photos.
# Once these files are locked up, you're not going to be making changes unless you want to upload the whole batch (2024 in this case) again.

# Zip up a pictures folder, in this case, for one year
# This is chosen to limit the blast radius of one corrupted file
# Use the folder name here on out ast the name of the backup (2024 in this case)
./zip.sh /Volumes/Primary\ SSD/Important/My\ Pictures/2024
# We don't trust them, use the passphrase in the firesafe/aWallet Cloud
# Make sure you MANUALLY enter the passphrase from a printed copy at least once to verify you can decrypt if all you have is that physical copy
./encrypt.sh 2024
# Split encrypted file into 100 MB chunks
./chunk.sh 2024

# TEST THE BACKUP
# Reconstruct the chunks (creates a -reconstructed file)
./reconstruct.sh 2024
# Test the decryption
./decrypt.sh 2024-reconstructed
# Unzip the zip file and browse the contents, verifying files look as expected
open ~/TeraBox/2024-reconstructed.zip

# Backup the parts, sha256 hash file
./backup.sh 2024 'My Pictures'  # Copies 2024-related files to ~/TeraBox/My Pictures, which TeraBox will automatically back up

# Clean up -- VERIFY!
# Unzipping my zip file created a Volumes directory
cd ~/TeraBox
rm -rf ./Volumes *-reconstructed* *.gpg *.zip

# Verify the files are getting backed up to TeraBox in the App
ls -lh ~/TeraBox/My\ Pictures/2024
```