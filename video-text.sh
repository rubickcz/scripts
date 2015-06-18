#!/bin/bash

source functions.sh

SCRIPT_NAME="video-text.sh"

# settings
OUTPUT_FILE="output.mp4"

echo_highlight "Input file?"
read -e INPUT_FILE 

echo_highlight "CRF?"
read -e CRF 

ffmpeg -i "$INPUT_FILE" -c:v libx264 -preset medium -crf $CRF -vf "" -c:a aac -b:a 256k -strict -2 \
-vf "drawtext=fontfile=/usr/share/fonts/truetype/ttf-dejavu/DejaVuSerif.ttf: \
	text='Hanácká mozeka Litovel':fontsize=50:fontcolor=white:x=w-tw-50:y=h-th-90:borderw=3
, drawtext=fontfile=/usr/share/fonts/truetype/ttf-dejavu/DejaVuSerif.ttf: \
	text='www.hanackamozeka.cz':fontsize=35:fontcolor=white:x=w-tw-50:y=h-th-45:borderw=2,yadif=0:-1:1" \
	"$OUTPUT_FILE"
