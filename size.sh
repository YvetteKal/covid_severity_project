#!/bin/bash

# Check if the directory is specified
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Navigate to the specified directory
cd "$1" || { echo "Directory not found"; exit 1; }

# Make sure we are inside a Git repository
if [ ! -d ".git" ]; then
    echo "No Git repository found in $1"
    exit 1
fi

# Get a list of files that Git would ignore
ignored_files=$(git ls-files --ignored --exclude-standard --others)

# Find all files, excluding the ignored ones, and calculate the total size
total_size=0

find . -type f | while read file; do
    # Check if the file is ignored by Git
    if echo "$ignored_files" | grep -qF "$file"; then
        continue
    fi

    # Get the file size and add it to the total size
    size=$(stat -f "%z" "$file")
    total_size=$((total_size + size))
done

# Convert the total size to MB
total_size_mb=$(echo "$total_size / 1048576" | bc -l)

# Print the total size in MB
echo "Total size of files in $1 (excluding Git ignored files): $(printf "%.2f" "$total_size_mb") MB"
