#cd ~
#while true; do
#	while [[ ! `ping 8.8.8.8 -c 3` ]] ; do sleep 60; done
cd ~/googledrive

gdfs -o allow_other,big_writes ./.gdfs.creds.couch ./couch/

gdfs -o allow_other,big_writes ./.gdfs.creds.scott ./scott/

#	while [[ `ping 8.8.8.8 -c 3` ]] ; do sleep 10; done
#	sudo umount .googledrive
#done

