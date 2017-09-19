#!/bin/bash
PRIMARY_LOG_DIR="/home/`whoami`/.breaklog"
DATED_LOG_DIR=`date "+%Y/%b/"`
DAY=`date "+%d"`
WHY_BREAK="`date "+%F:%T"` :: "

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

WHY_BREAK+=$SECONDARY_REASON

echo
echo "$WHY_BREAK" >> "$PRIMARY_LOG_DIR/$DATED_LOG_DIR/$DAY.log"
echo "$WHY_BREAK"
echo
echo "Logged"
