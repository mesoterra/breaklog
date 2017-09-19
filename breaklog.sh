#!/bin/bash
#Function to clear all variables
CLEAR_ALL () {
unset PRIMARY_LOG_DIR
unset DATED_LOG_DIR
unset DAY
unset WHY_BREAK
unset PRIMARY_REASON
unset BREAK
unset LUNCH
unset PUNCH_BACK
unset SECONDARY_REASON
unset LUNCH_DURATION
unset BREAK_1
unset BREAK_2
unset BREAK_3
}

#Flush all variables to stoically prevent the unexpected
CLEAR_ALL

#Set initial variables
PRIMARY_LOG_DIR="/home/`whoami`/.breaklog"
DATED_LOG_DIR=`date "+%Y/%b/"`
DAY=`date "+%d"`
WHY_BREAK="`date "+%F:%T"` :: "
LUNCH_DURATION="30"
BREAK_1="5"
BREAK_2="10"
BREAK_3="15"

#Make log dir and file
mkdir -p "$PRIMARY_LOG_DIR/$DATED_LOG_DIR"
touch "$PRIMARY_LOG_DIR/$DATED_LOG_DIR/$DAY.log"

#Break type menu
echo "Welcome to Breaklog, select a reason"
echo "1) Work related?"
echo "2) A break?"
echo "3) Lunch time?"
echo "4) End of day wrap up?"
echo "5) Coming back?"
echo "6) Other?"
read PRIMARY_REASON

#Menu selection parsing
case $PRIMARY_REASON in
 1)
  WHY_BREAK+="Work related :: "
  ;;
 2)
  WHY_BREAK+="Break :: "
  BREAK="1"
  ;;
 3)
  WHY_BREAK+="Lunch :: "
  LUNCH="1"
  ;;
 4)
  WHY_BREAK+="End of day wrap up :: "
  ;;
 5)
  WHY_BREAK+="##Punch Back##"
  PUNCH_BACK="1"
  ;;
 6)
  WHY_BREAK+="Other :: "
  ;;
 *)
  echo "Please start over and pick a valid reason"
  CLEAR_ALL
  exit
esac

#Logging function for punching back in
if [[ $PUNCH_BACK == '1' ]] ; then
 echo "$WHY_BREAK" >> "$PRIMARY_LOG_DIR/$DATED_LOG_DIR/$DAY.log"
 echo
 echo "$WHY_BREAK"
 echo
 CLEAR_ALL
 exit
fi

#Additional information about break
echo "Why are you doing this?"
read SECONDARY_REASON

WHY_BREAK+=$SECONDARY_REASON

#Log it all
echo
echo "$WHY_BREAK" >> "$PRIMARY_LOG_DIR/$DATED_LOG_DIR/$DAY.log"
echo "$WHY_BREAK"
echo
if [[ $LUNCH == "1" ]] ; then
 echo "Your lunch will end at $(date "+%F:%T" --date=$LUNCH_DURATION\ minutes)"
fi
if [[ $BREAK == "1" ]] ; then
 printf "Take note of the below return times.\n15 minutes: $(date "+%F:%T" --date=$BREAK_3\ minutes)\n10 minutes: $(date "+%F:%T" --date=$BREAK_2\ minutes)\n5 minutes: $(date "+%F:%T" --date=$BREAK_1\ minutes)\n"
fi
echo
echo "Logged"
CLEAR_ALL
