#!/bin/bash

#With this line we define where's the "bin"
BIN=~/bin

#If the folder "bin" doesn't exist, it will create it for you
if [ ! -d "$BIN" ]; then
    echo "=================================="
    echo
    echo "Creating bin on: $BIN"
    echo
    echo "=================================="
    mkdir -p "$BIN"
fi

#If the user doesn't introduce any file to delete or parameter, will show the help.
if [ "$#" -eq 0 ]; then
    echo "=================================="
    echo
    echo "How to use: ./clean [parameters] [file]"
    echo ""
    echo "Parameters:"
    echo "  -L            List the content of the bin."
    echo "  -R [file]     Recover a file from the bin."
    echo "  -h            Show this help."
    echo
    echo "=================================="
    exit 1
fi

#The "-h" parameter shows the help.
if [ "$1" == "-h" ]; then
    echo "=================================="
    echo
    echo "How to use: ./clean [parameters] [file]"
    echo ""
    echo "Parameters:"
    echo "  -L            List the content of the bin."
    echo "  -R [file]     Recover a file from the bin."
    echo "  -h            Show this help."
    echo
    echo "=================================="
    exit 0
fi

#The "-L" parameter lists the content of the bin.
if [ "$1" == "-L" ]; then
    echo "=================================="
    echo
    echo "Content of the bin:"
    echo
    ls -l "$BIN"
    echo
    echo "=================================="
    exit 0
fi

#With the "-R" parameter you can recover any file from the bin, if the file isn't on the bin it will display an error and exit the script.
if [ "$1" == "-R" ]; then
    if [ -z "$2" ]; then
        echo "=================================="
        echo
        echo "Error: Yous must specify a file to recover."
        echo
        echo "=================================="
        exit 1
    fi
    if [ -e "$BIN/$2.gz" ]; then
        gunzip "$BIN/$2.gz"
        mv "$BIN/$2" ./
        echo "=================================="
        echo
        echo "$2 has been recovered from the bin."
        echo
        echo "=================================="
    else
        echo "=================================="
        echo
        echo "Error: There isn't a file called $2 on the bin."
        echo
        echo "=================================="
    fi
    exit 0
fi

#Verifys if there is a file to move to the bin, if not, display an error and exit the script.
if [ -z "$1" ]; then
    echo "=================================="
    echo
    echo "Error: No files where specified."
    echo
    echo "=================================="
    exit 1
fi

#Verifys if a file is trully a file, in case it is a directory, displays an error an exit the script.
if [ -e "$1" ]; then
    if [ -d "$1" ]; then
        # Si es un directorio, no permitir su eliminación
        echo "Error: $1 is a directory and can't be moved to the bin."
    else
        # Comprimir el archivo y moverlo a la papelera
        gzip -c "$1" > "$BIN/$1.gz"
        rm "$1"
        echo "=================================="
        echo        
        echo "$1 zipped and moved to the bin."
        echo
        echo "=================================="     
    fi
else
    echo "=================================="
    echo
    echo "There isn't a file called $1 on the bin."
    echo
    echo "=================================="
fi
