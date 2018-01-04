if [ ! -e /tmp/.urxvtd_running ]; then
	urxvtd &
	touch /tmp/.urxvtd_running
fi
urxvtc -fg green -bg black
