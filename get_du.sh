#!/bin/bash

if [ $# -eq 0 ]; then
	target="./*"
else
	target="$@"
fi


for file in $target; do
	echo "$file"
	du --human-readable --total "$file" | grep "total"
	echo ""
done

exit 0
