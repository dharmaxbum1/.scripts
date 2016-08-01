#!/bin/bash
## Define the filename to use as output
motd="/etc/motd"
## Collect useful information about your system
# System
SYS=`/bin/uname -srmo`
PROCS=`/bin/ps ax | /bin/wc -l | /bin/tr -d " "`
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
G="\033[32;1m"
X="\033[00;37m"
## Time
upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
UPTIME=`/bin/printf "%d days, %02dh %02dm %02ds " "$days" "$hours" "$mins" "$secs"`
DATE=`/bin/date +"%A, %e %B %Y, %r"`
## THE OUTPUT
clear 											    		        >  $motd # to clear the screen when showing up
echo -e "$R#=============================================================================#" 		        >> $motd
echo -e "$X"  									            		        >> $motd
echo -e "$W             ___________     _______                _________"   		   		        >> $motd
echo -e "$W      ___  __\__    ___/___  \      \   ____  __ __/   _____/ ____  __ __"   		        >> $motd
echo -e "$W      \  \/  / |    | /  $R_ $W \ /   |   \ /  $G_ $W \|  |  \_____  \ /  $B_ $W \|  |  \\"   	>> $motd
echo -e "$W       >    <  |    |(  $R<_>$W )    |    (  $G<_>$W )  |  /        (  $B<_>$W )  |  /"   		>> $motd
echo -e "$W      /__/\_ \ |____| \____/\____|__  /\____/|____/_______  /\____/|____/"   		        >> $motd
echo -e "$W            \/                      \/                    \/"   				        >> $motd
echo -e "$X"										   		        >> $motd
echo -e "$R#=============================================================================#" 		        >> $motd
echo -e "   $G$DATE"						        					>> $motd
echo -e "   $G$SYS"						        					>> $motd
echo -e "  $X"										   		        >> $motd
echo -e "  $R UPTIME..........:$W $UPTIME  $R RUNNING PROCESSES: $W$PROCS"	   		                >> $motd
echo -e "  $R CPU TEMPERATURE.:$W $TEMPCPU"$CEL"                   $R HDD TEMPERATURE..:$W $TEMPHDD"$CEL""	>> $motd
echo -e "  $R HDD USAGE.......:$W $HDDUSED"GiB"                $R HDD FREE.........:$W $HDDFREE"GiB"" 		>> $motd
echo -e "  $R MEMORY USAGE....:$W $MEMUSED"MiB"               $R MEMORY FREE......:$W $MEMFREE"MiB""            >> $motd
echo -e "  $R BATTERY.........:$W $BAT    	           $R SOUND VOLUME.....:$W $SOUND"%""			>> $motd
echo -e "  $R LOCAL IP........:$W $IPLOC    	   $R PUBLIC IP........:$W $IPPUB"			        >> $motd
echo -e "$R#=============================================================================#" 		        >> $motd
echo -e "$X" 										    		        >> $motd
echo -e "$R                          	   WARNING"   		                                		>> $motd
echo -e "$X    This is a private system that you are not to give out access to anyone"   		        >> $motd
echo -e "$X    without permission from the admin. No illegal files or activity. Stay,"   		        >> $motd
echo -e "$X    in your home directory, keep the system clean, and make regular backups."   		        >> $motd
echo -e "$X      -== DISABLE YOUR PROGRAMS FROM KEEPING SENSITIVE LOGS OR HISTORY ==-"   		        >> $motd
echo -e "$W                          MAY THE FORCE BE WITH YOU"   		                                >> $motd
echo -e "$X"   		                                                                                        >> $motd
