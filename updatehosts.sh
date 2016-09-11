#!/bin/bash
#
## Bash script to update hostsfile
## Dependencies: wget, curl, printf

# Vars
HOSTS='https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts'
PATH_TO_HOSTS='/etc'

# Colors vars
GREEN="\033[1;32m"
RED="\033[1;31m"
NORMAL="\e[1;0m"

# Command Vars
HTTP_CODE=`curl -Is $HOSTS | head -1 | awk {'print $2'}`
BACKUP_OLD_HOSTS=`cp /etc/hosts /etc/hosts.old 2> /dev/null`
REMOVE_OLD_HOSTS=`rm -f /etc/hosts 2> /dev/null`
GET_HOSTS=`wget -q $HOSTS -P $PATH_TO_HOSTS 2> /dev/null`

function main() {

   if [[ -f /etc/hosts ]]; then
      if [ "${HTTP_CODE}" = "200" ]; then
         ${BACKUP_OLD_HOSTS}
         ${REMOVE_OLD_HOSTS}
         ${GET_HOSTS}
         echo -e "$GREEN \bDone$NORMAL"
      else
         echo -e "$RED \bSource unreachable$NORMAL"
      fi
   fi
}

function check_su() {

   if [ "$EUID" -ne 0 ];
      then echo -e "$RED \berror:$NORMAL You cannot perform this operation unless you are root."
      exit
   fi
}

check_su
main
