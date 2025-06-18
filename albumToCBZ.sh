#!/bin/bash

convertSeries()
{
	base=$1

	if [ -d "$base" ]; then
		return 0
	elif [ -e "$base".cbz ]; then
		return 0
	fi

	mkdir "$base"
	for file in $base-*; do
		mv "$file" "$base/${file#$base-}"
	done

	echo "Compressing album $base to cbz..."
	zip -r9 "$base.cbz" "$base/"
	rm -r "$base/"
	
	return 1
}

for file in *; do
	base="${file%%-*}"
	# echo $file $base
	if [ -e "$base-001-"*.??? ] && [ -e "$base-002-"*.??? ]; then
		convertSeries "$base"
	fi
done

exit