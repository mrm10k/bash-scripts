# Clean Script

A simple Bash script to manage files by moving them to a "bin" directory, listing, or recovering them. This acts like a local trash bin to temporarily store and manage files safely.

## Features
- **Move files to the bin** (compressed as `.gz` files).
- **List contents** of the bin directory.
- **Recover files** from the bin.
- **Help display** with usage instructions.

## Setup

Ensure the script is executable by running:

``bash
chmod +x clean.sh``

## Usage
 ``./clean.sh [parameters] [file]``

### Parameters

- **``-L``**: List the contents of the bin.
- **``-R``**: Recover a specific file from the bin.
- **``-h``**: Display help information.
