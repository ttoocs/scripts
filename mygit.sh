
MYGITDIR=~/Sync/myGit

CMD=$1 ; shift
if [ $CMD == "new" ]; then
  cd $MYGITDIR && \
  git init --bare $@
fi

