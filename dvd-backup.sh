#!/bin/bash

# DVD backup 
# author: Ondrej Kulaty (rubick)
#
# Backups DVD to smaller MP4 file

source functions.sh

SCRIPT_NAME="dvd-backup.sh"

# settings
VOB_TMP_DIR="vob_tmp"
DVD_DEVICE="/dev/sr0"
OUTPUT_FILE="output.mp4"

# 1) create/clean tmp directory and copy VOB files
if [ -d "$VOB_TMP_DIR" ]; then
	echo_warn "$VOB_TMP_DIR directory exists?"
	echo_highlight "Overwrite? (y/n)"
	read -e ANSWER
	if [ "$ANSWER" == "y" ]; then
		# overwrite directory
		rm -rf "${VOB_TMP_DIR}"
		mkdir_and_check "$VOB_TMP_DIR"

		# copy VOB files 
		echo_message "Copying VOB files..."
		dvdbackup -i "$DVD_DEVICE" -o . -F -n "$VOB_TMP_DIR" 
		if [ $? -ne 0 ]; then
			echo_err "Something went wrong with dvdbackup, exiting..."
			exit 1
		fi
	fi
fi

# 3) encode VOB files
echo_highlight "Set CRF [default: 18]:"
read -e CRF
if [ "$CRF" == "" ]; then
	CRF="18"
fi
VOB_FILES=""
for file in $VOB_TMP_DIR/VIDEO_TS/*.VOB; do
	VOB_FILES="${VOB_FILES}./$file|"
done
ffmpeg -i concat:$VOB_FILES -c:v libx264 -preset medium -crf "$CRF" -vf "yadif=0:-1:1" -c:a aac -b:a 256k -strict -2 "$OUTPUT_FILE"
