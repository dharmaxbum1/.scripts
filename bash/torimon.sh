#!/bin/bash

TV="HDMI1"
LAPTOP="eDP1"
_1080_="1920x1080"

function show_usage() {
  
  echo "torimon tv"
  echo "torimon laptop"
  echo "torimon mirror"
  echo "torimon extend"
  exit
}

function check_xrandr() {

  ! hash xrandr && echo "Please install xrandr first." && exit 	
}

function __init__() {
	
  check_xrandr
  
  case "$1" in
    "tv")
      xrandr --output "${TV}" --mode "${_1080_}" --output "${LAPTOP}" --off
    ;;
    "laptop")
      xrandr --output "${LAPTOP}" --mode "${_1080_}" --output "${TV}" --off
    ;;
    "mirror")
      xrandr --output "${LAPTOP}" --mode "${_1080_}" --output "${TV}" --mode "${_1080_}" --same-as "${LAPTOP}"
    ;;
    "extend")
      xrandr --output "${TV}" --mode "${_1080_}" --right-of "${LAPTOP}" --mode "${_1080_}"
    ;;
    *)
      show_usage
    ;;
  esac
  
  exit
}

if [[ -z "$1" ]]; then
  show_usage
fi

__init__ "$1"
