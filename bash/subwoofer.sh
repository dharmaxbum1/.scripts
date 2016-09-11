#! /usr/bin/env sh
#
########## Requires python2 and hda-analyzer #########
## wget http://www.alsa-project.org/hda-analyzer.py ##
## su -c 'python2 hda-analyzer.py'                  ##
## sed -i 's/python %s/python2 %s/' hda-analyzer.py ##
######################################################
#
# by xtonousou
# simple script to turn on subwoofer, for lenovo y50-70
#

if [ $(id -u) -ne 0 ];	then
	echo -e "\033[01;31mPlease run as root"
	exit 999
fi

dev="/dev/snd/hwC1D0"

hda-verb $dev 0x17 SET_POWER 0x0
hda-verb $dev 0x1a SET_POWER 0x0
hda-verb $dev 0x03 0x300 0xa055
hda-verb $dev 0x03 0x300 0x9055
hda-verb $dev 0x17 0x300 0xb000
hda-verb $dev 0x17 0x707 0x40
hda-verb $dev 0x1a 0x707 0x25
