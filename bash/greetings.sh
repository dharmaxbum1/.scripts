#!/bin/bash
# Shell program which gets executed the moment the user logs in, it should
# display the message "Good morning", "Good Afternoon", or "Good Evening"
# depnding upon the time which the user logs in.
# =====================================================================
# Q. How to run this script as soon as user logs in?
# A. Open your bash startup file aka profile file - ~/.bash_profile
# and put path to this script in file as follow:
# . /path/to/greetings.sh
# -----------------------------------------------
# Copyright (c) 2005 nixCraft project 
# This script is licensed under GNU GPL version 2.0 or above
# -------------------------------------------------------------------------
# This script is part of nixCraft shell script collection (NSSC)
# Visit http://bash.cyberciti.biz/ for more information.
# -------------------------------------------------------------------------
# get current hour (24 clock format i.e. 0-23)
hour=$(date +"%H")
# if it is midnight to midafternoon will say G'morning
if [ $hour -ge 0 -a $hour -lt 12 ]
then
  greet="Good Morning, Master $USER"
# if it is midafternoon to evening ( before 6 pm) will say G'noon
elif [ $hour -ge 12 -a $hour -lt 18 ]
then
  greet="Good Afternoon, Master $USER"
else # it is good evening till midnight
  greet="Good evening, Master $USER"
fi
# display greet
echo $greet
