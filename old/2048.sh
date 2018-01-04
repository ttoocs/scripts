sleep 5;
while true; do
 for c in {0..256}; do
 for b in {0..10}; do
 for a in {0..32}; do
 for i in w a; do xdotool key $i 
 done 
 done 
 xdotool key s 
 done
 xdotool click 1; scrot $c.png 
 done
done
