#!/bin/bash

[[ $(basename $PWD) == "MySuperVault" ]] || {
    echo "Executed from wrong directory: $(basename $PWD) != MySuperVault"
    exit 1
}

subjects="ADDA IISSI1 RC LI SO"
echo "Current list of subjects:"
for s in $subjects; do
    echo -e "\t- $s"
done

echo ""


for s in $subjects; do
    shopt -s nullglob
    notes=(+/${s}*)
    shopt -u nullglob
    # for n in "${notes[@]}"; do echo "$n"; done # DEBUG

    if [ ${#notes[@]} -eq 0 ]; then
        echo -e "No notes for subject $s\n"
        continue
    fi

    if [ ! -d "Efforts/Software Engineering/${s}" ]; then
        echo -e "No directory for subject: $s\n"
        continue
    fi

    

    echo "Subject: $s"
    echo "Notes: ${notes[@]}"

	read -r -p "Move notes to subject's directory? [Y/n]: " confirm
	if [ "$confirm" == "n" ] || [ "$confirm" == "N" ]; then
        echo ""
		continue
	fi

    mv -i "${notes[@]}" "Efforts/Software Engineering/${s}"
    echo ""
done
