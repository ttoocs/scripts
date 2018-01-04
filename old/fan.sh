#!/bin/bash

FILE=/tmp/fan.state
FAN=/proc/acpi/ibm/fan
ST=`cat $FILE`

if [ "$ST" == "0" ]; then
    echo level auto | sudo tee $FAN 
    echo auto > $FILE
else
    for i in {0..7} auto; do
    a=$i
    let a++
    if [  "$ST" == "$i" ] ; then		
    	echo level $a | sudo tee $FAN || a="0"
    	echo level $a | sudo tee $FAN 
    	echo $a > $FILE
    fi
    done
fi
#	rm $FILE
#	sudo 
#fi



#FOR X ONLY :<
#xset dpms force off

#glxgears &
#echo $(date) > /tmp/backlight.sh
