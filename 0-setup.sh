#!/bin/sh

# Repos/dependencies
sudo add-apt-repository --yes ppa:zfs-native/stable
sudo apt-get update


# Install cloud-utils
# See: http://ubuntu-smoser.blogspot.com/2014/08/mount-image-callback-easily-modify.html
sudo apt-get install --yes cloud-utils

# Install ZFS on Linux
sudo apt-get install --yes ubuntu-zfs
sudo modprobe zfs
