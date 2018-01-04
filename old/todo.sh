#!/bin/bash
exit
#I don't use it.

VER=1
echo "FINISH TODO SYSTEM"

if [ $VER -eq 2 ]; then

#TODO:
#Permit tasks in due date format
#Organize/show them in the due-date format
#Permit MISC task, (IE, no due date)
#Easy addition of tasks
#Easy marking of complettion of tasks
#Daily tasks
#Copy tasks
#modify/edit tasks

DATECMD=`date +%d:%m:%y`



#3 tasks types: 
#   Recurring (hourly, daily, weekly, month... etc.)
#   Due-date tasks (ex. Pay bills by sept.)
#   Misc tasks  (No due date, but just work on it.)
#      Possibly with a timer of due it for X ammount a day.


# Data-structure of tasks:
#   Each task as a file in ~/tasks or ~/todo
#   NAME="Blah"
#   DONE=false
#   INFO="For the blahde blah foo project."
#   PROG="libreoffice ~/thefooproject.doc"
#   ADDED=$DATECMD
#   COMPLETED=$DATECMD
#   DUE=dd:mm:yy
#   TYPE=
#       RECURRING:
#           RE_TIME= (#of hours)        
#           RE_DATE= (#of hours)
#       ONESHOT
#       OTHER
#           


#TODO: Parse the lists in ~/todo.sh
#FORMAT: month day year blahbla till end of line


#OLD VERSION
elif [ $VER -eq 1 ]; then

#Make them organised by dates, current firstmost, past-dates hiden.
sh ~/scripts/urxvt.sh -geometry 30x10 -name 'todo' -e watch head ~/todo.txt 

fi


exit


$OLD NOTES ON V2

#for i in ~/todos/* ; do
#cat $i | awk -v p=`echo $i | cut -d'/' -f5` '{
#if ( $1 !~ /#/ )
#    print $0=p": "$0
#}'
#done

##POSSIBLY: sync with google calander (adding tasks, and getting them.)

#OLD VERSION:

#Not sure how to make sure it keeps running :/
#while true; do
#    PID=$!
#    echo $PID

#done
