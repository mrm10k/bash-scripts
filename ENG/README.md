# clean.sh

A simple Bash script to manage files by moving them to a "trash" directory, listing, or recovering them. This acts like a local trash directory to temporarily store and manage files safely.

---
## Features
- **Move files to the trash** (compressed as `.gz` files).
- **List contents** of the trash directory.
- **Recover files** from the trash.
- **Help display** with usage instructions.

---
## Setup

Ensure the script is executable by running:

``bash
chmod +x clean.sh``

---
## Usage
 ``./clean.sh [parameters] [file]``

---
## Parameters
- **``-L``**: List the contents of the trash.
- **``-R``**: Recover a specific file from the trash.
- **``-h``**: Display help information.

---
## Example Commands
1. **``./clean.sh example.txt``**: Move a file to the trash.
2. **``./clean.sh -L``**: List content of the trash.
3. **``./clean.sh -R example.txt``**: Recover a file from the trash.
4. **``./clean.sh -h``**: Show help.

---
## How it works
1. **Move Files to the trash:**
- The specified file is compressed to .gz format and moved to ~/trash.
- If the ~/trash directory doesn't exist, it is created automatically.
 
2. **List Files:**
- Displays the content of the ~/trash directory.

3. **Recover Files:**
- Decompresses the .gz file and restores it to the current directory.
   
4. **Restrictions:**
- The script does not delete directories (only individual files are allowed).

---
## Error handling

- If no parameters or files are provided, the script shows help information.
- If you attempt to move a directory, the script will block the operation and display an error.
- If you try to recover a non-existent file, an appropriate error message is shown.

---


# dupe.sh.

## Features
**Auto-install the requirements and check the duped files in a directory checking and comparing the file hashes**

---
## Setup
Ensure the script is executable by running:
`sudo chmod +x dupe.sh`

---
## Example commands
`dupe.sh .`
`./dupe.sh /home/`
`dupe.sh /`

---
## Error handling
- If no directory are provided will show the syntax help and exit the script.
- If the directory provided doesn't exists will exit the script and display an error.
- If the option provided aren't "y" or "n" will return to the start of the loop and ask for one option. 
---
