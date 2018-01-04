#if $1 == "mount"; then
#exit

#while true; do
#    while [[ ! `ping 8.8.8.8 -c 3` ]] ; do sleep 60; done
	sshfs scott.saunders@linux.cpsc.ucalgary.ca:"/home/ugc/scott.saunders" /home/fu-fu/uofc.home -o reconnect	-o sshfs_sync

 #   while [[ `ping 8.8.8.8 -c 3` ]] ; do sleep 10; done
 #   sudo umount /home/fu-fu/uofc.home
#done

#fi

