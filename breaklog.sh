#!/bin/bash
PRIMARY_LOG_DIR="/home/`whoami`/.breaklog"
DATED_LOG_DIR=`date "+%Y/%b/"`
DAY=`date "+%d"`
WHY_BREAK="`date "+%F:%T"` :: "
unset LUNCH
unset BREAK

mkdir -p "$PRIMARY_LOG_DIR/$DATED_LOG_DIR"
touch "$PRIMARY_LOG_DIR/$DATED_LOG_DIR/$DAY.log"

echo "Welcome to Breaklog, select a reason"
echo "1) Work related?"
echo "2) A break?"
echo "3) Other?"
read PRIMARY_REASON

case $PRIMARY_REASON in
 1)
  WHY_BREAK+="Work related :: "
  ;;
 2)
  WHY_BREAK+="Break :: "
  BREAK="1"
  ;;
 3)
  WHY_BREAK+="Other specified, read note :: "
  ;;
 *)
  echo "Please start over and pick a valid reason"
  exit
esac

echo "Why are you doing this?"
read SECONDARY_REASON

if [[ $SECONDARY_REASON == *"Lunch"* ]] || [[ $SECONDARY_REASON == *"lunch"* ]] ; then
 echo "Is this a lunch break?"
  read LUNCH
  case $LUNCH in
   yes)
    LUNCH="1"
    unset BREAK
    ;;
   no)
    unset LUNCH
    ;;
   *)
    echo "Start over and pick a valid option"
    exit
    ;;
  esac
fi

WHY_BREAK+=$SECONDARY_REASON

echo
echo "$WHY_BREAK" >> "$PRIMARY_LOG_DIR/$DATED_LOG_DIR/$DAY.log"
echo "$WHY_BREAK"
echo
if [[ $LUNCH == "1" ]] ; then
 echo "Your lunch will end at $(date "+%F:%T" --date='30 minutes')"
fi
if [[ $BREAK == "1" ]] ; then
 printf "Take note of the below return times.\n15 minutes: $(date "+%F:%T" --date='15 minutes')\n10 minutes: $(date "+%F:%T" --date='10 minutes')\n5 minutes: $(date "+%F:%T" --date='5 minutes')"
fi
echo
echo "Logged"
