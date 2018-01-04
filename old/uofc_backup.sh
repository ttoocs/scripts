if [[ -e ~/uofc.home/.mounted ]]; then
    rsync uofc.home/* -avzue --delete uofc.home.local/
else
    echo "UofC not mounted, not going to try to mount it."
fi

