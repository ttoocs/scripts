#!/bin/bash
if [ -e /tmp/backupinprogress ]
then
	echo "Backup running"
	exit
fi
touch /tmp/backupinprogress
sh ~/scripts/uofc_backup.sh #Backs up UofC files.

IP="192.168.1.101"
#IP="192.168.2.101"
DATE=`date +%y-%m-%d-%H`
SSH="$IP -C -p 443 -l share"
BACKUPDIR="/shared/Scott/Backup/Home/current/"
#echo "Taring home"
#cd ~

date
echo $DATE >> /home/fu-fu/backup.log
cd /home
#TODO Make this btrfs send/receive
#btrfs send -p "/home/fu-fu/share/Backup/Home/current/" "/home" | ssh -C -p 443 $IP btrfs receive $BACKUPDIR && ssh $SSH $BACKUPDIR/scripts/backup2.sh 

rsync -avzue "ssh -C -p 443" --delete fu-fu/ share@$IP:$BACKUPDIR && ssh $SSH $BACKUPDIR/scripts/backup2.sh && sh ~/backupdone.sh 
date
(sleep 86400 ; rm /tmp/backupinprogress) &
#Make only one backup per day

#rm -r /home/fu-fu/Downloads/*
#tar -zcf /mnt/shared/Scott/Backup/Home/home.backup.$DATE.tar.gz ./
#tar -zc ./*  > /tmp/backup.pipe &


#cp -a home.backup.$DATE.tar.gz /mnt/shared/Scott/Backup/Home/
