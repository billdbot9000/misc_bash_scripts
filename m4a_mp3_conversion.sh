#!/bin/bash

for file in *.m4a; do
	basename=${file/.m4a};
	if [ ! -e "$basename".mp3 ]; then
		faad -o -- "$file" | lame -V4 - "$basename".mp3
	fi
done
