#!/bin/bash
for file in terraform*.sh; do
    if [ -e "$file" ]; then
        rm -rf "$file"
    fi
done