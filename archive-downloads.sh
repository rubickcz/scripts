#!/bin/bash

# Author: Ondrej Kulaty aka rubick
# Version: 1.0
#
# This script is used for cleaning your Downloads directory gets filled up
# with files by your browser (e.g. Chromium). The script will
# backup (archive) them to a specified directory. Works only for regular files.
# Will not move directories so far.

PROGRAM_NAME="archive-downloads"
# Dir where downloaded files are stored
DOWNLOADS_DIR="${HOME}/Downloads/"
# Destination dir for storing archived files
ARCHIVE_DIR="${DOWNLOADS_DIR}archive/"

# Functions

# Simple echo with program name prefix
echo_message() {
	echo "[${PROGRAM_NAME}]: $@"
}

# Same as message but prints to stderr
echo_err() {
	echo_message "$@" 1>&2
}

# Create dir and check if succeded. If not, terminate.
mkdir_and_check() {
	mkdir "$1"
	if [ $? -ne 0 ]; then
		echo_err "Creating directory failed!"
		exit 1
	fi
}


# Script begin
echo_message "Will now archive files from ${DOWNLOADS_DIR}"

# Check if archive directory
if [ ! -d "${ARCHIVE_DIR}" ]; then
	echo_message "Creating archive directory: ${ARCHIVE_DIR}"
	mkdir_and_check ${ARCHIVE_DIR}
fi

# Create new dir with today's date (if doesn't exists)
DIRNAME="$(date +%d-%m-%Y)"
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
