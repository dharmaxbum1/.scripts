#!/bin/bash

MAIN=

function greet() {

  sleep 0.2 && echo "-----------------------------------------"
  sleep 0.2 && echo "-------- xdg directory generator --------"
  sleep 0.2 && echo "-----------------------------------------"
  sleep 1
  clear
}

function input_main_dir() {

  sleep 0.2 && echo "-------------------------------------------"
  sleep 0.2 && echo "--- Insert the name of master directory ---"
  sleep 0.2 && echo "---------- and press [ENTER] --------------"
  sleep 0.2 && echo "-------------------------------------------"
  sleep 0.2 && echo "--------- e.g. /home/username -------------"
  sleep 0.2 && echo "-------------------------------------------"
  read MAIN
  clear
}

function input_dirs() {

  echo "-----------------------------------------"
  echo "--- Insert the name of each directory ---"
  echo "---------- and press [ENTER] ------------"
  echo "-----------------------------------------"
  echo -n ":: Desktop: "
  read DESKTOP
  echo -n ":: Documents: "
  read DOCUMENTS
  echo -n ":: Downloads: "
  read DOWNLOADS
  echo -n ":: Music: "
  read MUSIC
  echo -n ":: Pictures: "
  read PICTURES
  echo -n ":: Public: "
  read PUBLIC
  echo -n ":: Templates: "
  read TEMPLATES
  echo -n ":: Videos: "
  read VIDEOS
}

function check_create_set_dirs() {

  local PATH_DESKTOP
  local PATH_DOCUMENTS
  local PATH_DOWNLOADS
  local PATH_MUSIC
  local PATH_PICTURES
  local PATH_PUBLIC
  local PATH_TEMPLATES
  local PATH_VIDEOS

  PATH_DESKTOP="${MAIN}/${DESKTOP}"
  PATH_DOCUMENTS="${MAIN}/${DOCUMENTS}"
  PATH_DOWNLOADS="${MAIN}/${DOWNLOADS}"
  PATH_MUSIC="${MAIN}/${MUSIC}"
  PATH_PICTURES="${MAIN}/${PICTURES}"
  PATH_PUBLIC="${MAIN}/${PUBLIC}"
  PATH_TEMPLATES="${MAIN}/${TEMPLATES}"
  PATH_VIDEOS="${MAIN}/${VIDEOS}"

  if [[ ! -d "${PATH_DESKTOP}" ]];   then mkdir "${PATH_DESKTOP}"   &> /dev/null; fi
  if [[ ! -d "${PATH_DOCUMENTS}" ]]; then mkdir "${PATH_DOCUMENTS}" &> /dev/null; fi
  if [[ ! -d "${PATH_DOWNLOADS}" ]]; then mkdir "${PATH_DOWNLOADS}" &> /dev/null; fi
  if [[ ! -d "${PATH_MUSIC}" ]];     then mkdir "${PATH_MUSIC}"     &> /dev/null; fi
  if [[ ! -d "${PATH_PICTURES}" ]];  then mkdir "${PATH_PICTURES}"  &> /dev/null; fi
  if [[ ! -d "${PATH_PUBLIC}" ]];    then mkdir "${PATH_PUBLIC}"    &> /dev/null; fi
  if [[ ! -d "${PATH_TEMPLATES}" ]]; then mkdir "${PATH_TEMPLATES}" &> /dev/null; fi
  if [[ ! -d "${PATH_VIDEOS}" ]];    then mkdir "${PATH_VIDEOS}"    &> /dev/null; fi

  xdg-user-dirs-update --set DESKTOP     "${PATH_DESKTOP}"
  xdg-user-dirs-update --set DOCUMENTS   "${PATH_DOCUMENTS}"
  xdg-user-dirs-update --set DOWNLOAD    "${PATH_DOWNLOADS}"
  xdg-user-dirs-update --set MUSIC       "${PATH_MUSIC}"
  xdg-user-dirs-update --set PICTURES    "${PATH_PICTURES}"
  xdg-user-dirs-update --set PUBLICSHARE "${PATH_PUBLIC}"
  xdg-user-dirs-update --set TEMPLATES   "${PATH_TEMPLATES}"
  xdg-user-dirs-update --set VIDEOS      "${PATH_VIDEOS}"
}

clear
greet
input_main_dir
input_dirs
check_create_set_dirs

echo ":: [ OK ]"
echo ":: Reboot to make changes"
