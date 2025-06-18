#!/bin/bash

# counts files updated after a date, currently hardcoded in check_date
# checks all files in directories starting with $basename + files one subdirectory down

function check_date() {
	# TODO: update date before use, or take in arbitrary date as parameter to check_date
	compVal=$(date -d 2022-09-01 +%s)
	dateStr=`stat -c '%y' "$1"`
	dateVal=$(date -d "$dateStr" +%s)
	
	if [ $dateVal -ge $compVal ]; then
		return 1
	else
		return 0
	fi
}

shopt -s nullglob
# TODO: update directory base name
basename="user_"
for dir in $basename*; do
	if [ -d "$dir" ]; then
		echo "Entering" $dir
		cd "$dir"
		totalFiles=0
		
		for file in *; do
			if [ -d "$file" ]; then
				cd "$file"
				for file2 in *; do
					check_date "$file2"
					totalFiles=$((totalFiles + $?))
				done
				cd ../
			else
				check_date "$file"
				totalFiles=$((totalFiles + $?))
			fi
		done
		cd ../
		echo -e $dir'\t'$totalFiles >> recentFiles.txt
	fi
done
