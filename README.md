# adifupload
Script to upload adif files to eQSL from Linux and, in the future, to other systems.

Edit adifupload/adifupload.sh and change the following variables to suit your needs:



Then:
cd adifupload
chmod +x adifupload.sh

Install the required packages (curl and inotify-tools):
#for debian and ubuntu:
sudo apt -y install curl inotify-tools

#for fedora and centos:
sudo yum -y install curl inotify-tools

And add it to your crontab at reboot:
@reboot /home/YOURUSERNAME/adifupload/adifupload.sh

Don't forget to change "YOURUSERNAME" to your username, otherwise it will not start.

As the script will start on reboot you have to reboot.
If you want to try the script without rebooting, simply run:
~/adifupload/adifupload.sh

It will remain running in foreground.
