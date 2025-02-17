#!/bin/bash


# Exit if Number of Arguments != 2
if [ $# -ne 2 ] && [ $# -ne 3 ]; then
	echo "Correct usage: $0 <target_path> <identificator> [-y]"
	exit 1
fi

if [ ! -e "$1" ]; then
	echo "Error: The specified target path does not exist."
	exit 1
fi



echo "Time of execution:	$(date)"
now=$(date +%Y%m%d%H%M)

echo "Target path:		$1"
echo "Identificator:		$2"

target="$1"
archive="/tmp/$now-$2.tar.gz"

echo "$target will be zipped into $archive"


if [ "$3" == "-y" ]; then
	echo "Continuing without asking."
else
	read -p "Continue? [y]/n: " confirm
	if [ "$confirm" == "n" ] || [ "$confirm" == "N" ]; then
		echo "Process terminated."
		exit 0
	fi
fi



echo "Now zipping $target to $archive"
echo "## PROGRESS: #################"
tar --create --verbose --gzip --file="$archive" "$target"
echo "##############################"
echo "$target was successfully zipped into $archive!"

#export f=$archive
#echo "The full path to $archive has been temporary stored in variable \$f"

exit 0
