#!/bin/bash

# ARCHIVE DOWNLOADS
# author: Ondrej Kulaty (rubick)
#
# This script is used for cleaning the downloads directory when it gets filled
# up with files downloaded by the web browser (e.g. Chromium). The script will
# backup (archive) the files to a specified directory. Works only for regular
# files so it will not move directories so far. Invoke without parameters from
# any location.

source functions.sh

# Dir where downloaded files are stored
DOWNLOADS_DIR="$(xdg-user-dir DOWNLOAD)"

# test if it exists
if [ ! -d "$DOWNLOADS_DIR" ]; then
    echo_err "$DOWNLOADS_DIR/ is not a directory!"
    exit 1
fi

# xdg-user-dir may return home directory
if [ "$DOWNLOADS_DIR" == ~ ]; then
    echo_err "Cannot find downloads dir, XDG_DOWNLOAD_DIR is probably not defined!"
    exit 1
fi

# Destination dir for storing archived files
ARCHIVE_DIR="${DOWNLOADS_DIR}/archive"

# Script begin
echo_message "Will now archive files from ${DOWNLOADS_DIR}/"

# Check if archive directory
if [ ! -d "${ARCHIVE_DIR}" ]; then
	echo_message "Creating archive directory: ${ARCHIVE_DIR}/"
	mkdir_and_check ${ARCHIVE_DIR}
fi

# Create a new dir with today's date (if doesn't exists)
DIRNAME="$(date +%Y-%m-%d_%H:%M:%S)"
DEST_DIR="${ARCHIVE_DIR}/${DIRNAME}"

if [ ! -d "${DEST_DIR}" ]; then
	echo_message "Creating destination directory: ${DEST_DIR}/"
	mkdir_and_check ${DEST_DIR}
fi

# Move files from downloads dir to destination dir
COUNTER=0
for i in "${DOWNLOADS_DIR}/"*; do
	# process only regular files
	if [ -f "${i}" ]; then
		echo_message "Archiving file: ${i}"
		mv "${i}" "${DEST_DIR}"
		COUNTER=$(($COUNTER+1))
	fi
done

echo_message "Done. Archived ${COUNTER} files."
exit 0
