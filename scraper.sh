#!/bin/bash

download_path="/tmp/scraper"
initial_name="${download_path}.html"
final_name="${download_path}_filtered.html"


if [ "$#" -ne 1 ]; then
    echo "Use: $0 <URL>"
    exit 1
fi


wget -q "$1" -O "$initial_name"

if [ $? -ne 0 ]; then
    echo "Error when downloading from URL: $1"
    exit 1
fi



grep -E '^(<h[1-6]>|<p>|</p>|<ul>|</ul>|<ol>|</ol>|<li>|</li>|<!DOCTYPE html>|<head>|</head>|<body>|</body>)' "$initial_name" > "$final_name"

echo "Done!"
filtered_file_path=$(wslpath -w "$final_name")
explorer.exe "$filtered_file_path"
exit 0
