# Update repos
sudo apt-get update

# Add PPA tools
sudo apt-get install --yes python-software-properties software-properties-common

# Install ZFS on Linux
sudo add-apt-repository --yes ppa:zfs-native/stable
sudo apt-get update
sudo apt-get install --yes ubuntu-zfs
sudo modprobe zfs

# Install cloud-utils
# See: http://ubuntu-smoser.blogspot.com/2014/08/mount-image-callback-easily-modify.html
sudo apt-get install cloud-utils

# Download cloud image
wget 'https://cloud-images.ubuntu.com/releases/14.04.1/release/ubuntu-14.04-server-cloudimg-amd64-disk1.img'

# Convert qcow2 image to raw format
qemu-img convert -O raw ubuntu-14.04-server-cloudimg-amd64-disk1.img ubuntu-14.04-server-cloudimg-amd64-disk1.dist.img

# Fix image. 
# This won't be necessary soon.
sudo mount-image-callback ubuntu-14.04-server-cloudimg-amd64-disk1.dist.img -- sh -c 'sed -i "s/, None/, SmartOS, None/" $MOUNTPOINT/etc/cloud/cloud.cfg.d/90_dpkg.cfg'

# Create a ZFS volume to write the image to
sudo fallocate -l 10G /myzpool.file
sudo zpool create myzpool /myzpool.file
sudo zfs create -V 5G myzpool/ubuntu

# Write the image and store it as a gzipped ZFS volume
sudo dd if=ubuntu-14.04-server-cloudimg-amd64-disk1.dist.img of=/dev/zvol/myzpool/ubuntu
sudo zfs send myzpool/ubuntu@snap | gzip > ubuntu-14.04-server-cloudimg-amd64-disk1.dist.zvol.gz
