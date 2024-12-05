#!/bin/bash

# Ensure that there is exactly 1 argument
if [ "$#" -ne 1 ]; then
	echo "Correct usage: $0 <target_file>"
	exit 1
fi

# Exit if $1 does not exist.
if [ ! -e "$1" ]; then
        echo "Error: The specified target file does not exist."
        exit 1
fi

# Variables
file="$1"
images=$(fzf -m -q "IMG_" --height=40% --header="Select the image files in order." --border --border-label="$PWD")

# Exit if $images is empty
if [ -z "$images" ]; then
	echo "Error: No files were selected."
	exit 1
fi



# Main loop
while IFS= read -r image; do
    if [ ! -e "$image" ]; then
        echo "Warning: File '$image' does not exist. Terminating process."
        exit 1
    fi
    echo -n "$image: "
    sed -i "0,/!\[\[\]\]/{s#!\[\[\]\]#![[$image]]#}" "$file"
    echo "Successfully inserted."
done <<< "$images"
