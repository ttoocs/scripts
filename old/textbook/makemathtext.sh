sleep 10
#beep
sleep 1
#beep
sleep 1
#beep
sleep 1
#if [ $1 -n ] then;
#	let i=$1
#else
	let i=0
#fi
#while true; do 
for i in {0..1500} ; do 
#for b in {0..5}; do

scrot $i.png
#	xdotool key F5
	sleep 3;
#done
xdotool click 1 
#let i++
sleep 10;
done
