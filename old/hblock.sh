#!/bin/sh

# Author:     Héctor Molinero Fernández <hector@molinero.xyz>
# Repository: https://github.com/zant95/hBlock
# License:    MIT, https://opensource.org/licenses/MIT

# Exit on errors
set -eu

# Globals
export LC_ALL=C

output='/etc/hosts'
redirection='0.0.0.0'
header="
127.0.0.1       localhost
127.0.1.1       $(uname -n)
255.255.255.255 broadcasthost
::1             ip6-localhost ip6-loopback
fe00::0         ip6-localnet ip6-mcastprefix
ff02::1         ip6-allnodes
ff02::2         ip6-allrouters
ff02::3         ip6-allhosts
"
sources='
	http://someonewhocares.org/hosts/hosts
	http://winhelp2002.mvps.org/hosts.txt
	https://adaway.org/hosts.txt
	https://isc.sans.edu/feeds/suspiciousdomains_High.txt
	https://mirror.cedia.org.ec/malwaredomains/justdomains
	https://pgl.yoyo.org/adservers/serverlist.php?hostformat=nohtml&mimetype=plaintext
	https://ransomwaretracker.abuse.ch/downloads/RW_DOMBL.txt
	https://raw.githubusercontent.com/zant95/hosts/master/hosts
	https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt
	https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt
	https://s3.amazonaws.com/lists.disconnect.me/simple_malware.txt
	https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt
	https://www.malwaredomainlist.com/hostslist/hosts.txt
	https://zeustracker.abuse.ch/blocklist.php?download=domainblocklist
'
# POSIX basic regex
#   \.com$              -> all domains that ends with '.com'.
#   ^example            -> all domains that starts whith 'example'.
#   ^sub\.example\.org$ -> domain 'sub.example.org'.
whitelist='
	^whitelist\.local$
	^adf\.ly$
'
blacklist='
	blacklist.local
'
help='
Usage: hblock [OPTION]...
 -O    Output file
 -R    Redirection IP
 -H    Hosts header
 -S    Hosts sources (space separated entries)
 -W    Whitelist (space separated entries, POSIX basic regex)
 -B    Blacklist (space separated entries)
 -y    Automatic "yes" to prompts
 -n    Automatic "no" to prompts
 -h    Print this help
'
assume='ask'

# Methods
logMsg() {
	printf -- '   - %s\n' "$@"
}

infoMsg() {
	printf -- '\033[1;33m + \033[1;32m%s \033[0m\n' "$@"
}

errorMsg() {
	printf -- '\033[1;33m + \033[1;31m%s \033[0m\n' "$@"
}

promptMsg() {
	printf -- '\033[1;33m + \033[1;33m%s \033[0m[y/N]: ' "$@"
	if [ "$assume" = 'yes' ]; then
		printf -- '%s\n' 'y'
		return 0
	elif [ "$assume" = 'no' ]; then
		printf -- '%s\n' 'n'
		return 1
	else
		read answer
		case "$answer" in
			[yY]|[yY][eE][sS]) return 0 ;;
			*) return 1 ;;
		esac
	fi
}

checkBinary() {
	type "$@" >/dev/null 2>&1
}

checkDownloadAbility() {
	if ! checkBinary curl && ! checkBinary wget; then
		errorMsg 'Either wget or curl are required for this script'
		exit 1
	fi
}

fetch() {
	if checkBinary curl; then
		curl -fsL -A 'Mozilla/5.0' "$@"
	else
		wget -qO- -U 'Mozilla/5.0' "$@"
	fi
}

# Arguments
while getopts 'hynO:R:H:S:W:B:' opt; do
	case "$opt" in
		O) output=$OPTARG ;;
		R) redirection=$OPTARG ;;
		H) header=$OPTARG ;;
		S) sources=$OPTARG ;;
		W) whitelist=$OPTARG ;;
		B) blacklist=$OPTARG ;;
		y) assume='yes' ;;
		n) assume='no' ;;
		h) printf -- "$help"; exit 0 ;;
		*) printf -- "$help"; exit 1 ;;
	esac
done

# Process:
blocklist=''

infoMsg 'Configuration:'
	logMsg "Hosts location: $output"
	logMsg "Redirection IP: $redirection"

infoMsg 'Downloading lists...'
	checkDownloadAbility
	for url in $sources; do
		logMsg "$url"
		content=$(fetch "$url") || true

		if
			[ -z "$content" ] &&
			! promptMsg 'Error downloading list, do you want to continue?'
		then
			exit 0
		fi

		blocklist=$(printf -- '%s\n%s\n' "$blocklist" "$content")
		unset content
	done

infoMsg 'Parsing lists...'
	logMsg 'Remove carriage return'
		blocklist=$(printf -- '%s\n' "$blocklist" | tr -d '\r')

	logMsg 'Remove comments'
		blocklist=$(printf -- '%s\n' "$blocklist" | sed 's/#.*$//g')

	logMsg 'Trim spaces'
		blocklist=$(printf -- '%s\n' "$blocklist" | sed 's/[[:blank:]]*$//g;s/^[[:blank:]]*//g')

	logMsg 'Remove empty lines'
		blocklist=$(printf -- '%s\n' "$blocklist" | sed '/^$/d')

	logMsg 'Select only hosts lines'
		ipRegex='\([[:digit:]]\{1,3\}\.\)\{3\}[[:digit:]]\{1,3\}'
		domainRegex='\([[:alnum:]_-]\{1,63\}\.\)\{1,\}[[:alpha:]][[:alnum:]_-]\{1,62\}'
		blocklist=$(printf -- '%s\n' "$blocklist" | sed -n "/^\($ipRegex[[:blank:]]\{1,\}\)\{0,1\}$domainRegex$/p")

	logMsg 'Remove old destination'
		blocklist=$(printf -- '%s\n' "$blocklist" | sed "s/^$ipRegex[[:blank:]]\{1,\}//g")

	logMsg 'Transform all entries to lowercase'
		blocklist=$(printf -- '%s\n' "$blocklist" | tr '[:upper:]' '[:lower:]')

	logMsg 'Remove local entries'
		localDomainRegex='/\.\localdomain[[:blank:]]*$/d;/\.\local[[:blank:]]*$/d'
		blocklist=$(printf -- '%s\n' "$blocklist" | sed "$localDomainRegex")

	logMsg 'Apply whitelist'
		for domain in $whitelist; do
			blocklist=$(printf -- '%s\n' "$blocklist" | sed "/$domain/d")
		done

	logMsg 'Apply blacklist'
		for domain in $blacklist; do
			blocklist=$(printf -- '%s\n%s\n' "$blocklist" "$domain")
		done

	logMsg 'Sort entries'
		blocklist=$(printf -- '%s\n' "$blocklist" | sort -u)

	logMsg 'Add new destination'
		blocklist=$(printf -- '%s\n' "$blocklist" | sed "s/^/$redirection /g")

infoMsg 'Generating hosts file...'
	template='# %s\n# <header>\n%s\n# </header>\n# <blocklist>\n%s\n# </blocklist>'
	hosts=$(printf -- "$template" "$(date)" "$header" "$blocklist")

if touch "$output" >/dev/null 2>&1; then
	printf -- '%s\n' "$hosts" | tee "$output" >/dev/null
elif checkBinary sudo; then
	printf -- '%s\n' "$hosts" | sudo tee "$output" >/dev/null
else
	errorMsg "Cannot write '$output': Permission denied"
	exit 1
fi

infoMsg "$(printf -- '%s\n' "$blocklist" | wc -l) hosts added!"

