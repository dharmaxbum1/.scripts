#!/bin/bash

#Path to file vars
PAC_LIST_NEW="/etc/pacman.d/mirrorlist.pacnew"
PAC_LIST_OLD="/etc/pacman.d/mirrorlist.old"
PAC_LIST_="/etc/pacman.d/mirrorlist"

#Colors vars
green_color="\033[1;32m"
red_color="\033[1;31m"
cyan_color="\033[1;36m"
normal_color="\e[1;0m"

function print_intro() {
	
	clear
	echo -e ${green_color}"  _________                          .__                  "
	sleep 0.15 && echo -e " /   _____/_____   ____   ____  __ __|  |  __ __  _____   "
	sleep 0.15 && echo -e " \_____   \\____ \_/ __ \_/ ___\|  |  \  | |  |  \/     \ "
	sleep 0.15 && echo -e " /        \  |_> >  ___/\  \___|  |  /  |_|  |  /  Y Y  \\"
	sleep 0.15 && echo -e "/_______  /   __/ \___  >\___  >____/|____/____/|__|_|  / "
	sleep 0.15 && echo -e "        \/|__|        \/     \/                       \/  "${normal_color}
	echo
	sleep 1.25
}

function clean_up {

	# Perform program exit housekeeping
	# Optionally accepts an exit status
	rm -f $PAC_LIST_OLD
	rm -f $PAC_LIST_NEW
	clear
	exit $1
}

function error_exit {

	# Display error message and exit
	printf "${red_color}${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	clean_up 1
}

if [ "$EUID" -ne 0 ]
  then echo -e "${red_color}Please run as root"
  exit
fi

print_intro

clear
printf "${cyan_color}###################### ${green_color}Menu ${cyan_color}######################\n"
printf "#                                                #\n"
printf "#${green_color} [1] ${normal_color}Speedtest existing mirrorlist and replace. ${cyan_color}#\n"
printf "#${green_color} [2] ${normal_color}Speedtest new mirrorlist and replace.      ${cyan_color}#\n"
printf "#${green_color} [3] ${normal_color}Update mirrorlist.                         ${cyan_color}#\n"
printf "#${green_color} [4] ${normal_color}Exit.                                      ${cyan_color}#\n"
printf "#                                                #\n"
printf "##################################################\n"

printf "\n${normal_color}Enter selection number and press [ENTER]: "

read input_selection_
clear

case $input_selection_ in
1)
	if [ -f $PAC_LIST_NEW ]; then
		printf "${green_color}Uncommenting servers in order to perform speedtest...\n"
		sed -i 's/^#Server/Server/' $PAC_LIST_NEW
		printf "${green_color}Started ranking. Please wait...\n"
		rankmirrors -n 6 $PAC_LIST_NEW
		printf "${green_color}Done\n"
		sleep 2
		clean_up 1
	else
		error_exit "$PAC_LIST_NEW does not exist!\n"
	fi
	;;
2)
	if [ -f $PAC_LIST_ ]; then
		printf "${green_color}Copying current mirrorlist...\n"
		cp $PAC_LIST_ $PAC_LIST_OLD
		printf "${green_color}Uncommenting servers in order to perform speedtest...\n"
		sed -i 's/^#Server/Server/' $PAC_LIST_OLD
		printf "${green_color}Started ranking. Please wait...\n"
		rankmirrors -n 6 $PAC_LIST_OLD > $PAC_LIST_
		printf "${green_color}Done\n"
		sleep 2
		clean_up 1
	else
		error_exit "$PAC_LIST_ does not exist!\n"
	fi
	;;
3)
	printf "${green_color}[1] ${cyan_color}IPv4\n"
	printf "${green_color}[1] ${cyan_color}IPv6\n"
	printf "${normal_color}\nEnter selection number and press [ENTER]: "
	read input_selection_protocol
	case $input_selection_protocol in
	1)
		content=$(wget https://www.archlinux.org/mirrorlist/?ip_version=4 -q -O -)
		curl https://www.archlinux.org/mirrorlist/?ip_version=4 2>/dev/null > $PAC_LIST_NEW
		printf "${green_color}Uncommenting servers in order to perform speedtest...\n"
		sed -i 's/^#Server/Server/' $PAC_LIST_NEW
		printf "${green_color}Started ranking. Please wait...\n"
		rankmirrors -n 6 $PAC_LIST_NEW > $PAC_LIST_
		printf "${green_color}Done\n"
		sleep 2
		clean_up 1
	;;
	2)
		content=$(wget https://www.archlinux.org/mirrorlist/?ip_version=6 -q -O -)
		curl https://www.archlinux.org/mirrorlist/?ip_version=4 2>/dev/null > $PAC_LIST_NEW
		printf "${green_color}Uncommenting servers in order to perform speedtest...\n"
		sed -i 's/^#Server/Server/' $PAC_LIST_NEW
		printf "${green_color}Started ranking. Please wait...\n"
		rankmirrors -n 6 $PAC_LIST_NEW > $PAC_LIST_
		printf "${green_color}Done\n"
		sleep 2
		clean_up 1
	;;
	esac ;;
4)
	clean_up 1
	;;
esac
