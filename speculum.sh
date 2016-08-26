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

#Number vars
mirrors_number=6

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

function print_main_menu() {
	
   clear
   printf "${cyan_color}###################### ${green_color}Menu ${cyan_color}######################\n"
   printf "#                                                #\n"
   printf "#${green_color} [1] ${normal_color}Rank existing mirrorlist and replace       ${cyan_color}#\n"
   printf "#${green_color} [2] ${normal_color}Rank new mirrorlist and replace            ${cyan_color}#\n"
   printf "#${green_color} [3] ${normal_color}Download, rank new mirrorlist and replace  ${cyan_color}#\n"
   printf "#${green_color} [4] ${normal_color}Download new mirrorlist                    ${cyan_color}#\n"
   printf "#${green_color} [5] ${normal_color}Exit                                       ${cyan_color}#\n"
   printf "#                                                #\n"
   printf "##################################################\n"
   
   printf "\n${normal_color}Enter selection number and press [ENTER]: "	
}

function print_sub_menu() {
   
   clear
   printf "${cyan_color}#################### ${green_color}Submenu ${cyan_color}#####################\n"
   printf "#                                                #\n"
   printf "#${green_color} [1] ${normal_color}IPv4${cyan_color}                                       #\n"
   printf "#${green_color} [2] ${normal_color}IPv6${cyan_color}                                       #\n"
   printf "#${green_color} [3] ${normal_color}Exit                                       ${cyan_color}#\n"
   printf "#                                                #\n"
   printf "##################################################\n"

   printf "${normal_color}\nEnter selection number and press [ENTER]: "
}

function show_mirror_value() {

   printf "${normal_color}Enter mirrors to have (default=6), and press [ENTER]: "
   read input_mirrors
   if [[ $input_mirrors =~ ^-?[0-9]+$ ]]
   then
      mirrors_number=$input_mirrors
	  printf "${green_color}Number of mirrors ==> ${red_color}$mirrors_number\n"
   else
      printf "${green_color}Number of mirrors ==> ${red_color}6\n"
   fi
}

function download_ipv4() {

   curl https://www.archlinux.org/mirrorlist/?ip_version=4 2>/dev/null > $PAC_LIST_NEW
   printf "${green_color}Saved as ${red_color}$PAC_LIST_NEW\n"
}

function download_ipv6() {

   curl https://www.archlinux.org/mirrorlist/?ip_version=6 2>/dev/null > $PAC_LIST_NEW
   printf "${green_color}Saved as ${red_color}$PAC_LIST_NEW\n"
}

function clean_up {

	# Perform program exit housekeeping
	# Optionally accepts an exit status
	rm -f $PAC_LIST_OLD
	#rm -f $PAC_LIST_NEW
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
print_main_menu
read input_selection_

case $input_selection_ in
1)
	if [ -f $PAC_LIST_ ]; then
	    show_mirror_value
		printf "${green_color}Copying current mirrorlist...\n"
		cp $PAC_LIST_ $PAC_LIST_OLD
		printf "${green_color}Uncommenting servers in order to rank them...\n"
		sed -i 's/^#Server/Server/' $PAC_LIST_OLD
		printf "${green_color}Started ranking. Please wait...\n"
		rankmirrors -n $mirrors_number $PAC_LIST_OLD > $PAC_LIST_
		printf "${green_color}Done\n"
		sleep 2
		clean_up 1
	else
		error_exit "$PAC_LIST_ does not exist!\n"
	fi
	;;
2)
	if [ -f $PAC_LIST_NEW ]; then
	    show_mirror_value
		printf "${green_color}Uncommenting servers in order to rank them...\n"
		sed -i 's/^#Server/Server/' $PAC_LIST_NEW
		printf "${green_color}Started ranking. Please wait...\n"
		rankmirrors -n $mirrors_number $PAC_LIST_NEW
		printf "${green_color}Done\n"
		sleep 2
		clean_up 1
	else
		error_exit "$PAC_LIST_NEW does not exist!\n"
	fi
	;;
3)
	print_sub_menu
	read input_selection_protocol
	case $input_selection_protocol in
	1)
		download_ipv4
		show_mirror_value
		printf "${green_color}Uncommenting servers in order to rank them...\n"
		sed -i 's/^#Server/Server/' $PAC_LIST_NEW
		printf "${green_color}Started ranking. Please wait...\n"
		rankmirrors -n $mirrors_number $PAC_LIST_NEW > $PAC_LIST_
		printf "${green_color}Done\n"
		sleep 2
		clean_up 1
	;;
	2)
		download_ipv6
		show_mirror_value
		printf "${green_color}Uncommenting servers in order to rank them...\n"
	    sed -i 's/^#Server/Server/' $PAC_LIST_NEW
		printf "${green_color}Started ranking. Please wait...\n"
		rankmirrors -n $mirrors_number $PAC_LIST_NEW > $PAC_LIST_
		printf "${green_color}Done\n"
		sleep 2
		clean_up 1
	;;
	3)
	    clean_up 1
		;;
	esac ;;
4)
	print_sub_menu
	read input_selection_protocol
	case $input_selection_protocol in
	1)
		download_ipv4
	;;
	2)
		download_ipv6
	;;
	3)
	    clean_up 1
		;;
	esac ;;
5)
	clean_up 1
	;;
esac
