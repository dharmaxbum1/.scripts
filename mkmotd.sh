#!/bin/bash
## Define the filename to use as output
motd="/etc/motd"
## Collect useful information about your system
# System
PROCS=`/bin/ps ax | /bin/wc -l | /bin/tr -d " "`
HOSTNAME=`uname -n`
KERNEL=`uname -r`
CPU=`awk -F '[ :][ :]+' '/^model name/ { print $2; exit; }' /proc/cpuinfo`
ARCH=`uname -m`
PACMAN=`pacman -Qu | wc -l`
# Network
IFACE=`/bin/cat /proc/net/route | /bin/awk 'NR==2{print $1}'`
IPLOC=`/bin/ifconfig $IFACE | /bin/grep inet\  | awk {'print $2'}`
IPPUB=`/bin/wget -q -O - http://icanhazip.com/`
# Memory
MEMUSED=`/bin/free   -m | /bin/grep Mem | /bin/awk {'print $3'}`
MEMFREE=`/bin/free   -m | /bin/grep Mem | /bin/awk {'print $4'}`
# Disk
HDDUSED=`/bin/df -h | /bin/grep sda6 | /bin/awk {'print $3'} | /bin/sed 's/[^0-9]*//g'`
HDDFREE=`/bin/df -h | /bin/grep sda6 | /bin/awk {'print $4'} | /bin/sed 's/[^0-9]*//g'`
# Battery
BAT=`/home/xtonousou/.scripts/./battery-status.sh | /bin/awk {'print $3'}`
# Speakers
SOUND=`/bin/amixer -R get Master | /bin/grep ^\ \ Front\ Left | /bin/awk {'print $5'} | /bin/sed 's/[^0-9]*//g'`
# Temperatures
CEL='\xe2\x84\x83'
TEMPCPU=`/bin/sensors | /bin/grep ^Physical | /bin/awk {'print $4'} | /bin/tr -d '+' | /bin/sed 's/..//3' | /bin/sed 's/..//2'`
TEMPHDD=`/home/xtonousou/.scripts/./hddtemp.sh | /bin/sed 's/..//2'`
## The different colours as variables
# W=white, B=blue, R=red, G=green, X=gray
W="\033[01;37m"
B="\033[01;34m"
R="\033[01;31m"
G="\033[01;32m"
X="\033[00;37m"
## Time
upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
UPTIME=`/bin/printf "%d days, %02dh %02dm %02ds " "$days" "$hours" "$mins" "$secs"`
DATE=`/bin/date +"%A, %e %B %Y, %r"`
# Time of day
HOUR=$(/bin/date +"%H")
if [ $HOUR -lt 12  -a $HOUR -ge 0 ]
then   TIME="morning"
elif [ $HOUR -lt 17 -a $HOUR -ge 12 ]
then   TIME="afternoon"
else   TIME="evening"
fi
clear > $motd
echo -e "   $G$DATE"						        					>> $motd
echo -e "$X"										   		        >> $motd
echo -e "                  $G. $W"										>> $motd
echo -e "                 $G/#\ $W                     _     $G _ _"						>> $motd
echo -e "                $G/###\ $W      __ _ _ __ ___| |__  $G| (_)_ __  _   ___  __"				>> $motd
echo -e "               $G/#####\ $W    / _' | '__/ __| '_ \ $G| | | '_ \| | | \ \/ /"				>> $motd
echo -e "              $G/##.-.##\ $W  | (_| | | | (__| | | |$G| | | | | | |_| |>  <"				>> $motd
echo -e "             $G/##(   )##\ $W  \__,_|_|  \___|_| |_|$G|_|_|_| |_|\__,_/_/\_\\"				>> $motd
echo -e "            $G/#.--   --.#\ $W"									>> $motd
echo -e "           $G/'           '\ "										>> $motd
echo -e "$X"										   		        >> $motd
echo -e "  $W Good $TIME$B,$W welcome to $B $HOSTNAME"						        	>> $motd
echo -e "  $R KERNEL..........:$W $KERNEL" 									>> $motd
echo -e "  $R CPU.............:$W $CPU" 									>> $motd
echo -e "  $R ARCH............:$W $ARCH" 									>> $motd
echo -e "  $R SYSTEM..........:$W $PACMAN packages can be updated" 						>> $motd
echo -e "  $R USERS...........:$W Currently `/bin/users | /bin/wc -w` user/users logged on " 			>> $motd
echo -e "  $X"										   		        >> $motd
echo -e "  $R UPTIME..........:$W $UPTIME  $R RUNNING PROCESSES: $W$PROCS"	   		                >> $motd
echo -e "  $R CPU TEMPERATURE.:$W $TEMPCPU"$CEL"                   $R HDD TEMPERATURE..:$W $TEMPHDD"$CEL""	>> $motd
echo -e "  $R HDD USAGE.......:$W $HDDUSED"GiB"                $R HDD FREE.........:$W $HDDFREE"GiB"" 		>> $motd
echo -e "  $R MEMORY USAGE....:$W $MEMUSED"MiB"               $R MEMORY FREE......:$W $MEMFREE"MiB""            >> $motd
echo -e "  $R BATTERY.........:$W $BAT    	           $R SOUND VOLUME.....:$W $SOUND"%""			>> $motd
echo -e "  $R LOCAL IP........:$W $IPLOC    	   $R PUBLIC IP........:$W $IPPUB"			        >> $motd
echo -e "$X" 										    		        >> $motd
echo -e "$R                          	   WARNING"   		                                		>> $motd
echo -e "$X    This is a private system that you are not to give out access to anyone"   		        >> $motd
echo -e "$X    without permission from the admin. No illegal files or activity. Stay,"   		        >> $motd
echo -e "$X    in your home directory, keep the system clean, and make regular backups."   		        >> $motd
echo -e "$X      -== DISABLE YOUR PROGRAMS FROM KEEPING SENSITIVE LOGS OR HISTORY ==-"   		        >> $motd
echo -e "$W                          MAY THE$R FORCE$W BE WITH YOU"   		                                >> $motd
echo -e "$X"   		                                                                                        >> $motd
