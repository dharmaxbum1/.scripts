## by xToNouSou
## this script is useful for Lenovo laptops which are using Lenovo Energy Manager,
## in Conservation mode (55% - 60%)

#!/bin/bash

RESTING="Resting";
UNKNOWN="Check your battery";
CHARGING="Charging";
DISCHARGING="Discharging";

showStatus=`cat /sys/class/power_supply/BAT1/status`
showCapacity=`cat /sys/class/power_supply/BAT1/capacity`

if [ "$showStatus" = "Unknown" ]
then
	echo "$RESTING at $showCapacity%"
elif [ "$showStatus" = "Charging" ]
then
	echo "$CHARGING, currently $showCapacity%"
elif [ "$showStatus" = "Discharging" ]
then
	echo "$DISCHARGING, currently $showCapacity%"
else
	echo "$UNKNOWN, currently $showCapacity%"
fi
