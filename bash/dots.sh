#!/bin/bash

# Replace "BLABLA" with the desired message to output with the dots
MSG="${1}"

while :; do
  echo -ne "${MSG} .\r"
  sleep .5
  echo -ne "${MSG} ..\r"
  sleep .5
  echo -ne "${MSG} ...\r"
  sleep .5
  echo -ne "\r\033[K"
done &

# Put desired command here, instead of sleeping for 10 seconds.
sleep 10

kill "${!}"
trap "kill ${!}" SIGTERM
echo -ne "\b"

