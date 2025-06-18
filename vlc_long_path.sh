#!/bin/sh

# hack to open video files with long file paths on Windows with VLC
# only useful if using WSL... pretty niche
# VLC issue documentation: https://code.videolan.org/videolan/vlc/-/issues/25640

filename_with_path=$1
filename=${filename_with_path##*/}
extension=${filename##*.}
tempname=${filename%%-*}.$extension

if [ ! -d /mnt/d/temp/ ]; then
	mkdir /mnt/d/temp/
fi

cp $filename_with_path /mnt/d/temp/$tempname
cd /mnt/d/temp/
"/mnt/c/Program Files (x86)/VideoLAN/VLC/vlc.exe" $tempname
rm /mnt/d/temp/$tempname
