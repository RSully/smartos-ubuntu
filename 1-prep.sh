#!/bin/sh

if [ ! -f ubuntu-14.04-server-cloudimg-amd64-disk1.img ]; then
	wget 'https://cloud-images.ubuntu.com/releases/14.04.1/release/ubuntu-14.04-server-cloudimg-amd64-disk1.img'
fi

# Convert compressed image to raw image
qemu-img convert -O raw ubuntu-14.04-server-cloudimg-amd64-disk1.img ubuntu-14.04-server-cloudimg-amd64-disk1.dist.img

# Convert raw image to exactly 2GB
qemu-img resize ubuntu-14.04-server-cloudimg-amd64-disk1.dist.img 2G
