#!/bin/bash


FILE=/tmp/backlight.toggle
if [ ! -e $FILE ] ; then
	touch $FILE
	#sudo vbetool dpms off //Stoped working 2016 march
	xset dpms force standby
else
	rm $FILE
	#sudo vbetool dpms on //Stoped working 2016 march
	xset -dpms
fi



#FOR X ONLY :<
#xset dpms force off

#glxgears &
#echo $(date) > /tmp/backlight.sh
