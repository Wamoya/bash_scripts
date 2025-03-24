#!/bin/bash

if [ $# -eq 0 ]; then
    target="./*"
else
    target="$@"
fi

for file in $target; do
    disk_usage=$(du --total --human-readable "$file" | grep total)
    name=$(basename "$file")
    echo -e "${disk_usage} \e[96m${name}\e[0m"
done

exit 0
