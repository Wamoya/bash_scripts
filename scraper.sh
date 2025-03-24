#!/bin/bash

local="/tmp/scraper.html"


if [ "$#" -ne 1 ]; then
    echo "Use: $0 <URL>"
    exit 1
fi


wget -q "$1" -O "$local"

if [ $? -ne 0 ]; then
    echo "Error when downloading from URL: $1"
    exit 1
fi



grep -E '^(<h[1-6]>|<p>|</p>|<ul>|</ul>|<ol>|</ol>|<li>|</li>|<!DOCTYPE html>|<head>|</head>|<body>|</body>)' "$local" > "${local}_filtered"

echo "Done!"
filtered_file_path=$(wslpath -w "${local}_filtered")
explorer.exe "$filtered_file_path"
exit 0
