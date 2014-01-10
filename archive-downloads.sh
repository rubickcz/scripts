#!/bin/bash

# ARCHIVE DOWNLOADS
# author: Ondrej Kulaty (rubick)
#
# This script is used for cleaning your downloads directory when it gets
# filled up with files by your browser (e.g. Chromium), but you don't
# want to delete them ritht now. The script will  backup (archive) them
# to a specified directory. Works only for regular files so it will not
# move directories so far. Invoke without parameters.

source functions.sh

# Dir where downloaded files are stored
DOWNLOADS_DIR="${HOME}/downloads/"
# Destination dir for storing archived files
ARCHIVE_DIR="${DOWNLOADS_DIR}archive/"

# Script begin
echo_message "Will now archive files from ${DOWNLOADS_DIR}"

# Check if archive directory
if [ ! -d "${ARCHIVE_DIR}" ]; then
	echo_message "Creating archive directory: ${ARCHIVE_DIR}"
	mkdir_and_check ${ARCHIVE_DIR}
fi

# Create new dir with today's date (if doesn't exists)
DIRNAME="$(date +%Y-%m-%d)"
DEST_DIR="${ARCHIVE_DIR}${DIRNAME}/"

if [ ! -d "${DEST_DIR}" ]; then
	echo_message "Creating destination directory: ${DEST_DIR}"
	mkdir_and_check ${DEST_DIR}
fi

# Move files from downloads dir to destination dir
COUNTER=0
for i in "${DOWNLOADS_DIR}"*; do
	# process only regular files
	if [ -f "${i}" ]; then
		echo_message "Archiving file: ${i}"
		mv "${i}" "${DEST_DIR}"
		COUNTER=$(($COUNTER+1))
	fi
done

echo_message "Done. Archived ${COUNTER} files."
exit 0
