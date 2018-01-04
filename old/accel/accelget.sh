cd ~/scripts/accel
sudo modprobe hdaps
while true; do 
cat /sys/devices/platform/hdaps/position >> data.txt
sleep 0.1
done

