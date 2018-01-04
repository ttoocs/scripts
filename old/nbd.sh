#!/bin/bash
sudo modprobe nbd
for i in {0..16}; do
sudo umount /dev/nbd$i
sudo nbd-client -d /dev/nbd$i
done

A="gentoo steam mint debain 1 2 3 4 5 6 7 8 9"
x=0
for i in $A; do 
sudo nbd-client -N $i 192.168.1.101 /dev/nbd$x
let x++
echo $i . $x
done

sudo mount /dev/nbd12 /mnt/debian -o compress-force=zlib

for mnt in debian; do
for i in sys proc dev; do
sudo mount /$i -o bind /mnt/$mnt/$i
done
done

