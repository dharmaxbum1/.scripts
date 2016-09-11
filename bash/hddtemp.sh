#!/bin/bash

# by xToNouSou
# reads HDD's temperature and prints it
# if HDD is unavailable it prints XX°C

check=$(sudo hdparm -C /dev/sda | grep state | awk {'print $4'})
temperature=$(sudo smartctl -A /dev/sda | grep Temp | awk {'print $10'})

if ( echo $check | grep -q 'active' || echo $check | grep -q 'standby' ); then
	echo $temperature"°C"
else
	echo "XX°C"
fi
