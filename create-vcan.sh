#!/bin/sh

# CREATE VCAN
# author: Ondrej Kulaty (rubick)
#
# This script creates virtual can interface.
# Your kernel must be compiled with CAN support.

source functions.sh

if [ "$1" = "" ];then
    echo_err "No interace name specified"
    exit 1
fi
NAME=$1

# load modules
sudo modprobe can
sudo modprobe can-dev
sudo modprobe can-raw
sudo modprobe vcan

# create can interfaces
sudo ip link add dev $NAME type vcan

# bring interface up
sudo ifconfig $NAME up
