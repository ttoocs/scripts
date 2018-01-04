ARG=" -cache 655350 -cache-min 1"
COOKIE_FILE=/var/tmp/youtube-dl-cookies.txt
mplayer $ARG -cookies -cookies-file ${COOKIE_FILE} $(youtube-dl -g --cookies ${COOKIE_FILE} $*)
