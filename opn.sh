#!/bin/bash

file=$(fzf --height=60% --header="Select the file to edit." --border --border-label="$PWD" --preview="cat {}")

# Exit if $file is empty
if [ -z "$file" ]; then
        echo "Error: No file was selected."
        exit 1
fi

# Exit if $file does not exist
IFS=
if [ ! -e "$file" ]; then
	echo "Error: $file does not exist."
	exit 1
fi

nvim "$PWD/$file"
