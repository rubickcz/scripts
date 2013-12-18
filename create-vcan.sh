#!/bin/sh

# This script creates virtual can interface.
# Your kernel must be compiled with CAN support.
# Run as root.

# load modules
modprobe can
modprobe can-dev
modprobe can-raw
modprobe vcan

NAME=$1

# create can interfaces
ip link add dev $NAME type vcan

# bring interface up
ifconfig $NAME up
