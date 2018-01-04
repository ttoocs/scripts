#!/bin/bash
TMPFILE=/tmp/splay`date +%s`
#mknod /tmp/fifo p > /dev/null

if [ ! $1 ]; then
	echo "arg1 = file, arg2 = slowdown (1=none), arg3 windowframe"
	exit
fi
if [ ! $2 ]; then
	S=2
else
	S=$2
fi
if [ ! $3 ]; then
	W=0.25
else
	W=$3
fi
if [ ! $4 ]; then
	O=10
else
	O=$4
fi

ffmpeg -i $1 -acodec pcm_s16le -ac 2 $TMPFILE.wav > /dev/null 2>/dev/null
paulstretch_newmethod.py -s $S -w $W -t $O $TMPFILE.wav $TMPFILE ;
rm $TMPFILE.wav &
echo "READY! Hit enter to play!"
read 
mpv	$TMPFILE
echo "WILL DELETE AFTER NEXT ENTER."
read
wait; rm $TMPFILE &
