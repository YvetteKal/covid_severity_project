#!/bin/bash

# Check if the directory is specified
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Navigate to the specified directory
cd "$1" || { echo "Directory not found"; exit 1; }

# Find and list files, excluding .git directory and files smaller than 10MB
find . -type f ! -path "*/.git/*" -exec stat -f "%z %N" {} \; | while read size file; do
    # Convert size to MB
    size_in_mb=$(echo "$size / 1048576" | bc -l)
    
    # Only print files larger than 10MB
    if (( $(echo "$size_in_mb > 10" | bc -l) )); then
        printf "%s %.2f MB\n" "$file" "$size_in_mb"
    fi
done
