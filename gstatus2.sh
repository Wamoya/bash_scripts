#!/bin/bash

ansi="\033[38;5;51m"

for dir in ~/repos/*; do
    cd "$dir" || continue

    if [ -d ".git" ]; then
        name=$(basename "$dir")
        status=$(git status -s)

        [ -z "$status" ] && continue

        echo -e "${ansi}${name}\033[0m"
        git status -sb
    fi
done    
        
