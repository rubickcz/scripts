#!/bin/bash

# RESIZE PHOTOS
# Author: Ondrej Kulaty (rubick)
#
# This script serves to resize photos to be uploaded to website
# It resize all photos in current PWD dir in ./output/[album_name]/
# It will also create album thumbnail.

source functions.sh

# trap interrupt signal
trap control_c SIGINT 

# 1) read album name
ALBUM_NAME=""
echo_highlight "Name of the album: "
read -e ALBUM_NAME
if [ "$ALBUM_NAME" == "" ]; then
    echo_err "Album name cannot be empty!"
    exit 1
fi

# 2) read input directory
INPUT_DIR=""
echo_highlight "Input directory [./]: "
read -e INPUT_DIR
if [ "$INPUT_DIR" == "" ]; then
    INPUT_DIR="./"
fi
if [ ! -d "$INPUT_DIR" ]; then
    echo_err "Input directory (${INPUT_DIR})  does not exist!"
    exit 1
fi

# 4) create output directory
OUTPUT_DIR=""
echo_highlight "Output directory [./output/]: "
read -e OUTPUT_DIR
if [ "$OUTPUT_DIR" == "" ]; then
    OUTPUT_DIR="./output/"
fi
mkdir_and_check "${OUTPUT_DIR}${ALBUM_NAME}"

# 5) photo size and annotation 
PHOTO_SIZE_OPTION=""
PHOTO_SIZE=""
echo_highlight "Choose preset:"
echo "1) Caption: Hanačka Litovel, Size: 450000 (approx. 822x548)"
echo "2) Caption: Hanácká mozeka Litovel, size: 785000 (approx. 1024x768)"

read -e PHOTO_SIZE_OPTION 
case $PHOTO_SIZE_OPTION in
    1) PHOTO_SIZE=450000; CAPTION="Hanačka Litovel" ;;
    2) PHOTO_SIZE=785000; CAPTION="Hanácká mozeka Litovel" ;;
    *) echo_err "Invalid option"; exit 1 ;;
esac

# 6) resize photos
for i in "${INPUT_DIR}"*.{jpg,JPG}; do
    if [ -f "${i}" ]; then
        echo_message "Resizing ${i}"
        convert "${i}" -quality 85 -auto-orient -strip -resize "@${PHOTO_SIZE}" \
        -gravity SouthEast \
        -stroke '#000C' -strokewidth 2 -annotate +5+5 "${CAPTION}" \
        -stroke  none   -fill white    -annotate +5+5 "${CAPTION}" \
        "${OUTPUT_DIR}${ALBUM_NAME}"/image-`date +%s%N`.jpg 
    fi
done

# 7) album thumbnail
echo_highlight "Specify photo filename which will be used as album thumbnail (leave empty for no thumbnail):"
read -e ALBUM_THUMBNAIL
if [ -f "${ALBUM_THUMBNAIL}" ]; then
    convert "${ALBUM_THUMBNAIL}" -resize x120 -gravity center  -crop 160x120+0+0 -quality 85 -strip +repage "${OUTPUT_DIR}${ALBUM_NAME}".jpg
fi
echo_message "Done!"
