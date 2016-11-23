#!/bin/bash

# CREATE SCRIPT
# author: Ondrej Kulaty (rubick)
#
# Creates skeleton for a BASH script
# usage: ./create-script.sh script-name.sh

source functions.sh

FILENAME=$1

if [ "$FILENAME" == "" ]; then
    echo_err "Script filename not specified"
    exit 1
fi

echo -n \
"#!/bin/bash

# SCRIPT NAME
# author: Ondrej Kulaty (rubick)
#
# Script description

source functions.sh" > $FILENAME

chmod +x $1
