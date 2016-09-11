#!/bin/bash
## by xtonousou
## simple script to automate xrandr usage

# Commands used
DUALCHECK=`/bin/xrandr --current | /bin/grep HDMI1\ c`
DUALAPPLY=`/bin/xrandr --output eDP1 --mode 1920x1080_48.00 --output HDMI1 \
--mode 1920x1080_60.00 --right-of eDP1`
SOLOAPPLY=`/bin/xrandr --output eDP1 --mode 1920x1080_48.00`

# Colors
B='\033[01;34m'
R='\033[01;31m'

if [[ $DUALCHECK ]]; then
    ${DUALAPPLY};
    printf "${B}Dual Monitor Profile Applied\n";
else
    ${SOLOAPPLY};
    printf "${R}Built In Monitor Only Profile Applied\n";
fi

exit 1
