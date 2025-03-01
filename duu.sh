#!/bin/bash

if [ $# -eq 0 ]; then
    target="./*"
else
    target="$@"
fi

for file in $target; do
    echo $(basename "$file")
    du --total --human-readable "$file" | grep total
    echo ""
done
