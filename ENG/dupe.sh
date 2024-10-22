#!/bin/bash

#:Title: dupe.sh
#:Version: 1.0
#:Author: Mario Rolando León
#:Date: 10/18/2024
#:Date[ESP]: 18/10/2024
#:Description: A script to delete duped files checking the hash of the files on the selected directory.

sudo apt install lolcat -y && sudo apt install figlet -y

clear
figlet -f ANSI -c DUPE.sh | lolcat
echo "                          Made by mrm10k" | lolcat
# Verify if the user has introduced a directory
if [ -z "$1" ]; then
  echo "======================================"
  echo
  echo "Use: dupe.sh <directory>"
  echo
  echo "======================================"
  exit 1
fi

DIRECTORY="$1"

# Verify if the directory exists
if [ ! -d "$DIRECTORY" ]; then
  echo "======================================"
  echo
  echo "$DIRECTORY does not exists."
  echo
  echo "======================================"
  exit 1
fi

echo "======================================"
echo
echo "Scanning files on: $DIRECTORY"
echo
echo "======================================"

# Creates a temp file to store the hashes
TEMP_HASHES=$(mktemp)

find "$DIRECTORY" -type f -exec sha256sum "{}" + > "$TEMP_HASHES"

# Search and process the duped hashes
DUPED=$(awk '{print $1}' "$TEMP_HASHES" | sort | uniq -d)

if [ -z "$DIRECTORY" ]; then
  echo "======================================"
  echo
  echo "No duped files were found."
  echo
  echo "======================================"
  rm "$TEMP_HASHES"
  exit 0
fi

# Open the decryptor for being sure that the user input doesn't interfieres with the loop
exec 3<&0

# Processing every single duped hash
while read -r HASH; do
  echo "======================================"
  echo
  echo "Archivos con hash $HASH:"
  echo
  echo "======================================"

  # Getting the files with the very same hash
  mapfile -t FILES < <(grep "^$HASH" "$TEMP_HASHES" | cut -d ' ' -f 3-)

  # Mostrar los archivos encontrados
  for FILES in "${FILES[@]}"; do
    echo "$FILES"
  done

  # Ask if the user want to keep a file
  while true; do
    echo "======================================"
    echo
    read -p "Do you want to remove every file but one? (y/n): " ANSWER <&3
    echo
    echo "======================================"
    case "$ANSWER" in
      [yY])
        # Keep only one and deleting the rest
        for ((i = 1; i < ${#FILES[@]}; i++)); do
          echo "Deleting: ${FILES[$i]}"
          rm -f "${FILES[$i]}"
        done
        break
        ;;
      [nN])
        echo "======================================"
        echo
        echo "No files were deleted for hash: $HASH."
        echo
        echo "======================================"
        break
        ;;
      *)
        echo "======================================"
        echo
        echo "Please introduce 'y' or 'n'."
        echo
        echo "======================================"
        ;;
    esac
  done
done <<< "$DUPED"

# Cerrar el decriptor
exec 3<&-

# Limpiar archivos temporales
rm "$TEMP_HASHES"

echo "======================================"
echo
echo "Process finished successfully."
echo
echo "======================================"
exit 0

#
#\|/          (__)
#     `\------(oo)
#       ||    (__)
#       ||w--||     \|/
#   \|/
#
#		By   -mR
