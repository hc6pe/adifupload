# adifupload
Script to upload adif files to eQSL from Linux and, in the future, to other systems.

Edit **adifupload/adifupload.sh** and change the following variables to suit your needs:

`#Where is your .adi file located? `

`#Specify the full path (change YOURUSERNAME to the homedir of your username)`

`ADIFILE="/home/YOURUSERNAME/.local/share/WSJT-X/wsjtx_log.adi"`

`#your eQSL username. Use CAPS altough I think lowercase will work as well`

`EQSLUSER="N0CALL"`

`#your EQSL password.`

`EQSLPASS="not-my-pass"`

`#your TrustedQSL Location located in tqsl by going to:`

`#Station Location -> Edit Location -> Next -> Data in "Station Location Name"`

`TQSLLOCATION="MyLocation"`

Then:

`
cd adifupload
`

`
chmod +x adifupload.sh
`

Install the required packages (trustedqsl,curl and inotify-tools):

**for debian and ubuntu:**

`
sudo apt -y install curl inotify-tools trustedqsl
`

**for fedora and centos:**

`
sudo yum -y install curl inotify-tools trustedqsl
`

And add it to your crontab at reboot. Don't forget to change "YOURUSERNAME" to your username homedir, otherwise it will not start:

`
crontab -e
`

`
@reboot /home/YOURUSERNAME/adifupload/adifupload.sh
`

As the script will start on reboot you have to reboot.
If you want to try the script without rebooting, simply run:

`
~/adifupload/adifupload.sh
`

It will remain running in foreground.
