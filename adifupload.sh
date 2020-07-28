#!/bin/bash
# update the adi file location. Also set EQSLUSER and EQSLPASS to your
# eqsl username and password
ADIFILE="/home/pi/.local/share/WSJT-X/wsjtx_log.adi"
EQSLUSER="N0CALL"
EQSLPASS="not-my-pass"

[ $EQSLUSER = "N0CALL" ] && { echo "set EQSLUSER and EQSLPASS to your eqsl.cc username and pass"; exit 1; }

which inotifywait &> /dev/null
existi=$?
which curl &> /dev/null
existc=$?

[ $existc -ne 0 ] || [ $existi -ne 0 ] && { 
	echo "Install inotifywait and curl"
	echo "If using debian or ubuntu: sudo apt install curl inotify-tools"
	echo "If using fedora or redhat: sudo yum -y install curl inotify-tools"
	echo
	echo "ERROR: Missing required tool... exiting"
	exit 1
}

TAIL=$(which tail)
CURL=$(which curl)

while read j
do
   echo "inside the loop"
   $TAIL -2 $ADIFILE > /tmp/log.adi
   $CURL -u $EQSLUSER:$EQSLPASS -F Filename=@/tmp/log.adi -F EQSL_USER=$EQSLUSER -F EQSL_PSWD=$EQSLPASS http://www.eqsl.cc/qslcard/ImportADIF.cfm

done <  <(inotifywait -q -e modify $ADIFILE)

