#!/bin/bash
# update the adi file location. Also set EQSLUSER and EQSLPASS to your
# eqsl username and password
ADIFILE="/home/YOURUSERNAME/.local/share/WSJT-X/wsjtx_log.adi"
EQSLUSER="N0CALL"
EQSLPASS="not-my-password"
TQSLLOCATION="YourLocation"

[ $EQSLUSER = "N0CALL" ] && { echo "set EQSLUSER and EQSLPASS to your eqsl.cc username and pass"; exit 1; }

which inotifywait &> /dev/null
existi=$?
which curl &> /dev/null
existc=$?
which tqsl &> /dev/null
existt=$?
res=$(($existt+$existc+$existi))

export DISPLAY=:0.0

[ $res -ne 0 ] && { 
	echo "Install trustedqsl,inotifywait and curl"
	echo "If using debian or ubuntu: sudo apt install curl inotify-tools trustedqsl"
	echo "If using fedora or redhat: sudo yum -y install curl inotify-tools trustedqsl"
	echo
	echo "ERROR: Missing a required tool... exiting"
	exit 1
}

TAIL=$(which tail)
CURL=$(which curl)
TQSL=$(which tqsl)

while [ true ]
do
   inotifywait -q -e modify $ADIFILE
   $TAIL -2 $ADIFILE > /tmp/log.adi
   $CURL -u $EQSLUSER:$EQSLPASS -F Filename=@/tmp/log.adi -F EQSL_USER=$EQSLUSER -F EQSL_PSWD=$EQSLPASS http://www.eqsl.cc/qslcard/ImportADIF.cfm
   $TQSL -d -u -a compliant -b 20200701 -x -l $TQSLLOCATION $ADIFILE
done

