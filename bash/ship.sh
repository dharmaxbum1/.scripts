#!/bin/bash
#
# ship stands for show ip
# do the math
#

### Colors
GREEN="\033[1;32m"
RED="\033[1;31m"
LIGHT_BLUE="\033[1;36m"
ORANGE="\033[1;33m"
NORMAL="\e[1;0m"

### Colored animation parts
WAVE_0="${LIGHT_BLUE}~~~~x~t~o~n~o~u~s${NORMAL}"
WAVE_1="${LIGHT_BLUE}~~~x~t~o~n~o~u~s~${NORMAL}"
WAVE_2="${LIGHT_BLUE}~~x~t~o~n~o~u~s~o${NORMAL}"
WAVE_3="${LIGHT_BLUE}~x~t~o~n~o~u~s~o~${NORMAL}"
WAVE_4="${LIGHT_BLUE}x~t~o~n~o~u~s~o~u${NORMAL}"
MAST="${ORANGE}!${NORMAL}"
DECK_DOWN="${ORANGE}_${NORMAL}"
DECK_LEFT="${ORANGE}\\\\${NORMAL}"
DECK_RIGHT="${ORANGE}/${NORMAL}"

### Websites
IPECHO="ipecho.net/plain"
GOOGLE="google.com"

### Dimensions
WINDOW_HEIGHT=`tput lines`
#WINDOW_WIDTH=`tput cols`

### Dialogs
DIALOG_ALL="[ ${GREEN}Interface${NORMAL} ]---[ ${GREEN}MAC${NORMAL} ]-----------------[ ${GREEN}IPv4${NORMAL} ]--------[ ${GREEN}IPv6${NORMAL} ]-----------------"
DIALOG_ALL_CIDR="[ ${GREEN}Interface${NORMAL} ]---[ ${GREEN}MAC${NORMAL} ]-----------------[ ${GREEN}IPv4${NORMAL} ]------------------------[ ${GREEN}IPv6${NORMAL} ]---------------------"
DIALOG_INTERFACES="[ ${GREEN}Interface${NORMAL} ]"
DIALOG_MAC="[ ${GREEN}Interface${NORMAL} ]---[ ${GREEN}MAC${NORMAL} ]----------"
DIALOG_IPV4="[ ${GREEN}Interface${NORMAL} ]---[ ${GREEN}IPv4${NORMAL} ]-------"
DIALOG_IPV4_CIDR="[ ${GREEN}Interface${NORMAL} ]---[ ${GREEN}IPv4${NORMAL} ]-------"
DIALOG_IPV6="[ ${GREEN}Interface${NORMAL} ]---[ ${GREEN}IPv6${NORMAL} ]-----------------"
DIALOG_IPV6_CIDR="[ ${GREEN}Interface${NORMAL} ]---[ ${GREEN}IPv6${NORMAL} ]---------------------"

### Commands
INTERFACES_ARRAY=($(ip -4 a | grep : | awk {'print $2'} | tr -d ':'))
MAC_ARRAY=($(ip -4 a show | grep inet | awk {'print $2'} | sed 's/\/.*//'))
IPV4_ARRAY=($(ip -4 a show | grep inet | awk {'print $2'} | sed 's/\/.*//'))
IPV6_ARRAY=($(ip -6 a show | grep inet | awk {'print $2'} | sed 's/\/.*//'))
IPV4_CIDR_ARRAY=($(ip -4 a show | grep inet | awk {'print $2'} | sed -e 's#.*\/\(\)#\1#'))
IPV6_CIDR_ARRAY=($(ip -6 a show | grep inet | awk {'print $2'} | sed -e 's#.*\/\(\)#\1#'))

function usage() {
	echo -e "ship: a handy simple network multitool"
	echo
	echo "Usage: Basic info"
	echo -e "${GREEN}ship -a ${NORMAL}.......: shows all basic info"
	echo -e "${GREEN}ship -i ${NORMAL}.......: shows active network interfaces"
	echo -e "${GREEN}ship -m ${NORMAL}.......: shows active network interfaces and their MAC  addresses"
	echo -e "${GREEN}ship -4 ${NORMAL}.......: shows active network interfaces and their IPv4 addresses"
	echo -e "${GREEN}ship -6 ${NORMAL}.......: shows active network interfaces and their IPv6 addresses"
	echo
	echo "Usage: Miscellaneous info"
	echo -e "${GREEN}ship -p ${NORMAL}.......: shows your public IP"
	echo -e "${GREEN}ship -t ${NORMAL}.......: shows latency (Source: Google)"
	echo -e "${RED}ship -s ${NORMAL}.......: shows download and upload bandwidth"
	echo -e "${GREEN}ship --animate ${NORMAL}: plays a short animation of a ship :)"
	echo
	echo -e "${NORMAL}You can pass the parameter ${GREEN}--cidr ${NORMAL}to include classless inter-domain routing"
	echo -e "e.g. ${GREEN}ship --cidr-a${NORMAL}"
	echo
	echo -e "Commands shown in ${RED}RED${NORMAL} are under development..."
	exit
}

function resize_window() {
	local HEIGHT=`tput lines`
	case "$1" in
		'--all') resize -s "$HEIGHT" 81 > /dev/null 2>&1; ;;
		'--cidr-all') resize -s "$HEIGHT" 101 > /dev/null 2>&1; ;;
	esac
}

function sailing_ship() {
	case $1 in
		0)
			echo    "   _~"
			echo    "_~ )_)_~"
			echo    ")_))_))_)"
			echo -e "${DECK_DOWN}${MAST}${DECK_DOWN}${DECK_DOWN}${MAST}${DECK_DOWN}${DECK_DOWN}${MAST}${DECK_DOWN}"
			echo -e "${DECK_LEFT}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_RIGHT}"
			echo -e "${WAVE_0}"
		;;
		1)
			echo    "    _~"
			echo    " _~ )_)_~"
			echo    " )_))_))_)"
			echo -e " ${DECK_DOWN}${MAST}${DECK_DOWN}${DECK_DOWN}${MAST}${DECK_DOWN}${DECK_DOWN}${MAST}${DECK_DOWN}"
			echo -e " ${DECK_LEFT}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_RIGHT}"
			echo -e "${WAVE_1}"
		;;
		2)
			echo    "     _~"
			echo    "  _~ )_)_~"
			echo    "  )_))_))_)"
			echo -e "  ${DECK_DOWN}${MAST}${DECK_DOWN}${DECK_DOWN}${MAST}${DECK_DOWN}${DECK_DOWN}${MAST}${DECK_DOWN}"
			echo -e "  ${DECK_LEFT}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_RIGHT}"
			echo -e "${WAVE_2}"
		;;
		3)
			echo    "      _~"
			echo    "   _~ )_)_~"
			echo    "   )_))_))_)"
			echo -e "   ${DECK_DOWN}${MAST}${DECK_DOWN}${DECK_DOWN}${MAST}${DECK_DOWN}${DECK_DOWN}${MAST}${DECK_DOWN}"
			echo -e "   ${DECK_LEFT}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_RIGHT}"
			echo -e "${WAVE_3}"
		;;
		4)
			echo    "       _~"
			echo    "    _~ )_)_~"
			echo    "    )_))_))_)"
			echo -e "    ${DECK_DOWN}${MAST}${DECK_DOWN}${DECK_DOWN}${MAST}${DECK_DOWN}${DECK_DOWN}${MAST}${DECK_DOWN}"
			echo -e "    ${DECK_LEFT}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_DOWN}${DECK_RIGHT}"
			echo -e "${WAVE_4}"
		;;
	esac
	sleep 0.4
}

function print_animated_sailing_ship() {
	for ((frame = 1; frame <= 4; frame++)); do
		clear
		sailing_ship ${frame}
	done
}

function show_interfaces() {
	echo -e $DIALOG_INTERFACES
	for ((i = 0; i < ${#IPV4_ARRAY[@]}; i++)); do
		echo "${INTERFACES_ARRAY[i]}"
	done
}

function show_mac() {
	echo -e $DIALOG_MAC
	for ((i = 0; i < ${#IPV4_ARRAY[@]}; i++)); do
		MAC_OF=`ip link show ${INTERFACES_ARRAY[i]} | grep link | awk {'print $2'}`
		echo -e "${INTERFACES_ARRAY[i]}\t\t$MAC_OF\t"
	done
}

function show_ipv4() {
	echo -e $DIALOG_IPV4
	for ((i = 0; i < ${#IPV4_ARRAY[@]}; i++)); do
		echo -e "${INTERFACES_ARRAY[i]}\t\t${IPV4_ARRAY[i]}";
	done	
}

function show_ipv4_cidr() {
	echo -e $DIALOG_IPV4_CIDR
	for ((i = 0; i < ${#IPV4_CIDR_ARRAY[@]}; i++)); do
		echo -e "${INTERFACES_ARRAY[i]}\t\t${IPV4_ARRAY[i]}${RED}/${IPV4_CIDR_ARRAY[i]}${NORMAL}";
	done	
}

function show_ipv6() {
	echo -e $DIALOG_IPV6
	for ((i = 0; i < ${#IPV6_ARRAY[@]}; i++)); do
		echo -e "${INTERFACES_ARRAY[i]}\t\t${IPV6_ARRAY[i]}";
	done	
}

function show_ipv6_cidr() {
	echo -e $DIALOG_IPV6_CIDR
	for ((i = 0; i < ${#IPV6_CIDR_ARRAY[@]}; i++)); do
		echo -e "${INTERFACES_ARRAY[i]}\t\t${IPV6_ARRAY[i]}${RED}/${IPV6_CIDR_ARRAY[i]}${NORMAL}";
	done	
}

function show_all() {
	resize_window --all
	echo -e $DIALOG_ALL
	for ((i = 0; i < ${#IPV4_ARRAY[@]}; i++)); do
		MAC_OF=`ip link show ${INTERFACES_ARRAY[i]} | grep link | awk {'print $2'}`
		echo -e "${INTERFACES_ARRAY[i]}\t\t$MAC_OF\t${IPV4_ARRAY[i]}\t${IPV6_ARRAY[i]}"
	done
}

function show_all_cidr() {
	resize_window --cidr-all
	echo -e $DIALOG_ALL_CIDR
	for ((i = 0; i < ${#IPV4_ARRAY[@]}; i++)); do
		MAC_OF=`ip link show ${INTERFACES_ARRAY[i]} | grep link | awk {'print $2'}`
		echo -e "${INTERFACES_ARRAY[i]}\t\t$MAC_OF\t${IPV4_ARRAY[i]}${RED}/${IPV4_CIDR_ARRAY[i]}${NORMAL}             \t${IPV6_ARRAY[i]}${RED}/${IPV6_CIDR_ARRAY[i]}${NORMAL}"
	done
}	

function show_public_ip() {
	PUBLIC_IP=$(curl -s $IPECHO; echo; 2>&1)
	HTTP_CODE_IPECHO=$(curl -Is $IPECHO | head -1 | awk {'print $2'} 2>&1)
	
	if [ "${HTTP_CODE_IPECHO}" = "200" ]; then
		echo "${PUBLIC_IP}"
	else
		echo "Please check your internet connection"
	fi
}

function show_avg_ping() {
	HTTP_CODE_GOOGLE=$(curl -Is $GOOGLE | head -1 | awk {'print $2'} 2>&1)
	if [ "${HTTP_CODE_GOOGLE}" = "302" ]; then
		echo "Playing ping pong with Google, please wait..."
		RESPONSE_TIME=$(ping -c 6 $GOOGLE | tail -1 | awk '{print $4}' | cut -d '/' -f 2)
		echo -e "Average response time: ${GREEN}${RESPONSE_TIME} ms${NORMAL}"
	else
		echo "Please check your internet connection"
	fi
}

function __init__() {
	if [ $# -gt 1 ]; then
		usage
		exit
	fi

	case "$1" in
		"-i") show_interfaces; ;;
		"-m") show_mac; ;;
		"-t") show_avg_ping; ;;
		"-p") show_public_ip --public; ;;
		"-a") show_all; ;;
		"--cidr-a") show_all_cidr; ;;
		"-4") show_ipv4; ;;
		"--cidr-4") show_ipv4_cidr; ;;
		"-6") show_ipv6; ;;
		"--cidr-6") show_ipv6_cidr; ;;
		"--animate") print_animated_sailing_ship; ;;
		*) usage; ;;
	esac	
}

__init__ $1
