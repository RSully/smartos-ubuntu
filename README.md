# smartos-ubuntu

Scripts to generate modern Ubuntu images for SmartOS. 

# background

Since [switching][0] to [Ubuntu Certified][1] images,
Joyent has not provided any recent Ubuntu images for SmartOS.
The Internet has various guides for installing Ubuntu on a SmartOS,
but none provide the same experience we have grown to love from Joyent's images. 

As a result, this project was born to document and automate the process.

# high level overview

**0-setup.sh**: setup an existing Ubuntu server to generate a SmartOS image

**1-prep.sh**: download the official cloud image from Ubuntu

**2-run.sh**: convert the official cloud image from Ubuntu into a SmartOS image

# tutorial

Run the following on an Ubuntu server to produce the SmartOS image:

```
sudo apt-get -y install git
git clone https://github.com/RSully/smartos-ubuntu.git
cd smartos-ubuntu/
bash 0-setup.sh 
bash 1-prep.sh 
bash 2-run.sh 
```

This process takes a while (downloading and running dd).
You will end up with a *zvol.gz* file.
Use this file with imgadm in the global zone of a SmartOS host.

[0]: https://www.joyent.com/blog/certified-ubuntu-images-available-in-joyent-cloud
[1]: http://wiki.joyent.com/wiki/display/jpc2/Ubuntu+Certified
