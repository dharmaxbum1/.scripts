#!/bin/bash
#
## Bash script to update hostsfile
## Dependencies: wget, curl, printf

# Vars
HOSTS='https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts'
PATH_TO_HOSTS='/tmp'

# Colors vars
GREEN="\033[1;32m"
RED="\033[1;31m"
NORMAL="\e[1;0m"

# Command Vars
GET_HTTP_CODE=`curl -Is $HOSTS | head -1 | awk {'print $2'}`
GET_HOSTS=`wget -q $HOSTS -P $PATH_TO_HOSTS 2> /dev/null`
MAKE_HOSTS=`touch /etc/hosts 2> /dev/null`
BACKUP_OLD_HOSTS=`cp /etc/hosts /etc/hosts.old 2> /dev/null`
UPDATE_HOSTS=`cat $PATH_TO_HOSTS/hosts > /etc/hosts 2> /dev/null`

function main() {

   if [[ -f /etc/hosts ]]; then
      if [ "${GET_HTTP_CODE}" = "200" ]; then
         ${BACKUP_OLD_HOSTS}
         ${GET_HOSTS}
         ${UPDATE_HOSTS}
         echo -e "$GREEN \bDone$NORMAL"
      else
         echo -e "$RED \bSource unreachable$NORMAL"
      fi
   else
      if [ "${GET_HTTP_CODE}" = "200" ]; then
         ${MAKE_HOSTS}
         ${BACKUP_OLD_HOSTS}
         ${GET_HOSTS}
         ${UPDATE_HOSTS}
         echo -e "$GREEN \bDone$NORMAL"
      else
         echo -e "$RED \bSource unreachable$NORMAL"
      fi
   fi
}

function check_su() {

   if [ "$EUID" -ne 0 ];
      then echo -e "$RED \bYou cannot perform this operation unless you are root.$NORMAL"
      exit
   fi
}

check_su
main
