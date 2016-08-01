#!/bin/bash
## Define the filename to use as output
motd="/etc/motd"
## Collect useful information about your system
# $USER is automatically defined
HOSTNAME=`uname -n`
KERNEL=`uname -r`
ARCH=`uname -m`
## Some useful commands to use
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
# W=white, B=blue, R=red, X=gray
W="\033[01;37m"
B="\033[01;34m"
R="\033[01;31m"
X="\033[00;37m"
## THE OUTPUT
clear 											    		        >  $motd # to clear the screen when showing up
echo -e "$R#=============================================================================#" 		        >> $motd
echo -e "$X"  									            		        >> $motd
echo -e "$W             ___________     _______                _________"   		   		        >> $motd
echo -e "$W      ___  __\__    ___/___  \      \   ____  __ __/   _____/ ____  __ __"   		        >> $motd
echo -e "$W      \  \/  / |    | /  _ \ /   |   \ /  _ \|  |  \_____  \ /  _ \|  |  \\"   		        >> $motd
echo -e "$W       >    <  |    |(  <_> )    |    (  <_> )  |  /        (  <_> )  |  /"   		        >> $motd
echo -e "$W      /__/\_ \ |____| \____/\____|__  /\____/|____/_______  /\____/|____/"   		        >> $motd
echo -e "$W            \/                      \/                    \/"   				        >> $motd
echo -e "$X"										   		        >> $motd
echo -e "$R#=============================================================================#" 		        >> $motd
echo -e "	$W Welcome $B $USER $W to $B $HOSTNAME"   						        >> $motd
echo -e "	$R ARCH   $W= $ARCH" 							  	       	        >> $motd
echo -e "	$R KERNEL $W= $KERNEL"							   		        >> $motd
echo -e "$R#=============================================================================#" 		        >> $motd
echo -e "	$R CPU TEMPERATURE $W= $B$TEMPCPU"$CEL"                 $B$TEMPHDD"$CEL" $W =$R HDD TEMPERATURE">> $motd
echo -e "	$R HDD USAGE       $W= $HDDUSED"GiB"             $HDDFREE"GiB"$W =$R HDD FREE" 		        >> $motd
echo -e "	$R MEMORY USAGE    $W= $MEMUSED"MiB"         $MEMFREE"MiB"$W =$R MEMORY FREE"  		        >> $motd
echo -e "	$R BATTERY 	 $W= $BAT    	        $SOUND"%"$W =$R SOUND VOLUME"			        >> $motd
echo -e "$R#=============================================================================#" 		        >> $motd
echo -e "$X" 										    		        >> $motd
echo -e "$W                          MAY THE FORCE BE WITH YOU"   		                                >> $motd
echo -e "$R     This is a private system that you are not to give out access to anyone"   		        >> $motd
echo -e "$R     without permission from the admin. No illegal files or activity. Stay,"   		        >> $motd
echo -e "$R     in your home directory, keep the system clean, and make regular backups."   		        >> $motd
echo -e "$R      -==  DISABLE YOUR PROGRAMS FROM KEEPING SENSITIVE LOGS OR HISTORY ==-"   		        >> $motd
echo -e "$X"   		                                                                                        >> $motd
