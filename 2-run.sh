#!/bin/sh

# Fix image to use SmartOS cloud-init data provder.
sudo mount-image-callback ubuntu-14.04-server-cloudimg-amd64-disk1.dist.img -- sh -c 'sed -i "s/, None/, SmartOS, None/" $MOUNTPOINT/etc/cloud/cloud.cfg.d/90_dpkg.cfg'

# Create a ZFS volume to write the image to
sudo fallocate -l 5G /myzpool.file
sudo zpool create myzpool /myzpool.file
sudo zfs create -V 2G myzpool/ubuntu

# Write the image and store it as a gzipped ZFS volume
sudo dd if=ubuntu-14.04-server-cloudimg-amd64-disk1.dist.img of=/dev/zvol/myzpool/ubuntu
sudo zfs snapshot myzpool/ubuntu@snap
sudo zfs send myzpool/ubuntu@snap | gzip > ubuntu-14.04-server-cloudimg-amd64-disk1.dist.zvol.gz

# Cleanup
sudo zfs destroy -r myzpool/ubuntu
sudo zpool destroy myzpool
sudo rm /myzpool.file
