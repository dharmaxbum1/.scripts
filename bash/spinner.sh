#!/bin/bash
# spinner for long running tasks
# start_spinner "Message"
# sleep 2
# stop_spinner $?

function spinner() {
  
  # $1 start/stop
  #
  # on start: $2 display message
  # on stop : $2 process exit status
  #           $3 spinner function pid (supplied from stop_spinner)
  
  local STEP
  local SPINNER_PARTS
  local DELAY

  case $1 in
    start)
      # calculate the column where spinner and status msg will be displayed
      let COLUMN=$(tput cols)-${#2}-8
      # display message and position the cursor in $COLUMN column
      echo -ne "${2}"
      printf "%${COLUMN}s"

      # start spinner
      STEP=1
      SPINNER_PARTS='\|/-'
      DELAY=${SPINNER_DELAY:-0.15}

      while :
      do
        printf "\b%s" "${SPINNER_PARTS:STEP++%${#SPINNER_PARTS}:1}"
        sleep "${DELAY}"
      done
    ;;
    stop)
      kill "$3" > /dev/null 2>&1
    ;;
    *)
      echo "Invalid argument!"
      exit 1
    ;;
  esac
}

function start_spinner {
  
  # $1 : msg to display
  spinner "start" "${1}" &
  # set global spinner pid
  SPINNER_ID=$!
  disown
}

function stop_spinner {
  
  # $1 : command exit status
  spinner "stop" "$1" "${SPINNER_ID}"
  unset SPINNER_ID
}
