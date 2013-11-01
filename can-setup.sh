#!/bin/sh

# This script creates virtual can interface.
# Your kernel must be compiled with CAN support.
# Run as root.

# load modules
modprobe can
modprobe can-dev
modprobe can-raw
modprobe vcan

# create can interfaces
ip link add dev can0 type vcan

# bring interface up
ifconfig can0 up
