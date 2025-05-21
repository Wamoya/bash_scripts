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

# Iterate through every line and count the ![[]] flags
file="$1"
count=$(grep -o '!\[\[\]\]' "$file" | wc -l)
echo "Total of available slots: $count"


# Images
images=$(fzf --multi --query="IMG_" --height=40% --header="Select the image files in order." --border --border-label="$PWD")

# Exit if $images is empty
if [ -z "$images" ]; then
	echo "Error: No files were selected."
	exit 1
fi

# Exit if number of images selected != $count
selected=$(echo $images | tr ' ' '\n' | wc -l)
if [ $selected -ne $count ]; then
    echo "Error: You must select exactly $count images. You selected $selected."
    exit 1
fi

i=0
echo "Files will be added in this order:"
while IFS= read -r image; do
    if [ ! -e "$image" ]; then
        echo "Warning: File '$image' does not exist. Terminating process."
        exit 1
    fi
    echo "- $image"
    i=$((i + 1))
done <<< "$images"
echo "Total: $i"

# Ask user confirm
read -p "Continue? [Y/n]: " confirm
if [[ "$confirm" == "n" || "$confirm" == "N" ]]; then
        echo "Process terminated."
        exit 0
fi

# Main loop
while IFS= read -r image; do
    echo -n "$image: "
    if sed --in-place "0,/!\[\[\]\]/{s#!\[\[\]\]#![[$image]]#}" "$file"; then
        echo "Successfully inserted."
    else
        echo "Error."
    fi
done <<< "$images"

exit 0
