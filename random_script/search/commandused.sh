#!/bin/bash

echo "Enter the tag you want to count (include brackets):"
read tag

# Escape brackets for grep
escaped_tag=$(echo "$tag" | sed 's/[\[\]]/\\&/g')

echo "Enter the filename:"
read filename

# Use grep to count occurrences of the tag, using the escaped version
count=$(grep -o "$escaped_tag" "$filename" | wc -l)

echo "The tag '$tag' appears $count times in $filename."

