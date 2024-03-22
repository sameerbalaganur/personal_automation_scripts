#!/bin/bash

# List all non-hidden files from the parent directory and all its subdirectories using a while read loop
# Ignoring hidden files and directories
# find . -type f ! -path '*/.*' -print0 | while IFS= read -r -d $'\0' file; do
#     echo "$file"
# done


# Find files larger than 100MB in the current directory and subdirectories
find . -type f -size +1k -size -5M -exec ls -lh {} \; | awk '{ print $9 ": " $5 }' > fileslessthan1mb.txt
