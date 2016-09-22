#!/bin/bash
#
## Bash script to update hostsfile
## Dependencies: wget, curl, printf

# Vars
HOSTS="https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
PATH_TO_HOSTS="/etc"

# Colors vars
GREEN="\033[1;32m"
RED="\033[1;31m"
NORMAL="\e[1;0m"

# Command Vars
HTTP_CODE=`curl -Is $HOSTS | head -1 | awk {'print $2'}`
BACKUP_OLD_HOSTS=`cp /etc/hosts /etc/hosts.old 2> /dev/null`
REMOVE_OLD_HOSTS=`rm -f /etc/hosts 2> /dev/null`
GET_HOSTS=`wget -q $HOSTS -P $PATH_TO_HOSTS 2> /dev/null`

function check_su() {

   if [ "$EUID" -ne 0 ]; then
      echo -e "$RED \berror:$NORMAL You cannot perform this operation unless you are root."
      exit
   fi
}

function main() {

   if [[ -f /etc/hosts ]]; then
      if [ "${HTTP_CODE}" = "200" ]; then
	     echo -e "$GREEN \bWebsite is up and running"
         sleep 0.5
         ${BACKUP_OLD_HOSTS}
         echo -e "$NORMAL \bKeeping backup of the previous version..."
         sleep 0.5
         ${REMOVE_OLD_HOSTS}
         echo -e "$NORMAL \bFetching..."
         ${GET_HOSTS}
         sleep 0.5
         echo -e "$NORMAL \bPlease reboot your computer for these changes to take effect"
      else
         echo -e "$RED \bSource unreachable$NORMAL"
      fi
   fi
}

check_su
main
