#SDCARD OVERLAY
#mount -t overlay overlay_root -o lowerdir=/,upperdir=/mnt/sdcard/upper,workdir=/mnt/sdcard/work /

#TMP OVERLAY
sudo mkdir /tmp/work /tmp/upper
sudo mount -t overlay overlay_root -o lowerdir=/,upperdir=/tmp/upper,workdir=/tmp/work /


#GENERAL
# mount -t overlay overlay -o lowerdir=/lower,upperdir=/upper,workdir=/work /merged

