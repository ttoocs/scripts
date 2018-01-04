#!/usr/bin/bash
DATE=`date +%y-%m-%d-%H`
SSH="192.168.1.101 -C -p 443 -l share"
BACKUPDIR="/shared/Scott/Backup/Home/current"

cd $BACKUPDIR
cd ..
btrfs subvol snapshot current $DATE

