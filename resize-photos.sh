#!/bin/bash

# Author: Ondrej Kulaty aka rubick
# Version: 1.0
#
# This script serves to resize photos to be uploaded to website
# It resize all photos in current PWD dir in ./output/[album_name]/
# It will also create album thumbnail

PROGRAM_NAME="resize-photos"

# Functions
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
# exit script (launched when user hits Control-C)
control_c() {
    echo -en "\n*** Ouch! Exiting ***\n"
    #cleanup
    exit $?
}

# trap interrupt signal
trap control_c SIGINT 

# 1) read album name
ALBUM_NAME=""
echo "Name of the album: "
read -e ALBUM_NAME
if [ "$ALBUM_NAME" == "" ]; then
    echo_err "Album name cannot be empty!"
    exit 1
fi

# 2) create output directory
OUTPUT_DIR="./output"
mkdir_and_check ${OUTPUT_DIR}
mkdir_and_check ${OUTPUT_DIR}/${ALBUM_NAME}

# 3) resize photos


COUNTER=0
for i in *.{jpg,JPG}; do
    if [ -f "${i}" ]; then
        echo "Resizing ${i}"
        convert "${i}" -quality 85 -auto-orient -strip -resize "@450000" ${OUTPUT_DIR}/${ALBUM_NAME}/image-${COUNTER}.jpg 
        COUNTER=$(($COUNTER+1))
    fi
done

# 4) album thumbnail
echo "Specify photo filename which will be used as album thumbnail:"
read -e ALBUM_THUMBNAIL
convert ${ALBUM_THUMBNAIL} -resize x120 -gravity center  -crop 160x120+0+0 -quality 85 -strip +repage ${OUTPUT_DIR}/${ALBUM_NAME}.jpg
echo "Done!"
