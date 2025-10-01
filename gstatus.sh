#!/bin/bash


for dir in ~/repos/*; do
    if [ -d "$dir" ]; then
        echo "$(basename "$dir")"
        (cd "$dir" && git status)
        echo "========================================================================"
    fi
done
