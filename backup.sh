#!/bin/bash


# Exit if Number of Arguments != 2 or 3
if [ $# -ne 2 ] && [ $# -ne 3 ]; then
	echo "Correct usage: $0 <input_path> <identificator> [-y]"
	exit 1
fi

if [ ! -e "$1" ]; then
	echo "Error: The specified input path does not exist."
	exit 1
fi



echo "Time of execution:	$(date)"
now=$(date +%Y%m%d%H%M)

echo "Input path:		$1"
echo "Identificator:		$2"

input="$1"
output="/tmp/$now-$2.tar.gz"

echo "$input will be zipped into $output"


if [ "$3" == "-y" ]; then
	echo "Continuing without asking."
else
	read -r -p "Continue? [Y/n]: " confirm
	if [ "$confirm" == "n" ] || [ "$confirm" == "N" ]; then
		echo "Process terminated."
		exit 0
	fi
fi



echo "Now zipping $input to $output"
# echo "## PROGRESS: #################"
# tar --create --verbose --gzip --file="$output" "$input"
# echo "##############################"
# echo "$input was successfully zipped into $output!"


# total=$(find $input -type f | wc --lines)
size=$(du -sb "$input" | awk '{print $1}')
#count=0

tar -cf - "$input" | pv -s "$size" | gzip > "$output"

# temp_tar="/tmp/temp_backup.tar"
# tar --create --file="$temp_tar" --files-from=/dev/null
#
# find "$input" -type f | while read -r file; do
#     count=$((count + 1))
#     echo -ne "\033[2K\r## PROGRESS: [$count/$total] $file"
#
#     tar --append --file="$temp_tar" -C "$(dirname "$file")" "$(basename "$file")"
# done
#
# echo -e "\nCompressing..."
# gzip "$temp_tar"
# mv "${temp_tar}.gz" "$output"

~/repos/bash_scripts/backup_aux.sh "$output"

exit 0
