if [[ ! `ps -Fe | grep -i urxvtd | grep -v grep` ]]; then
	urxvtd &
	sleep 1
fi
urxvtc -fg green -bg black $@
