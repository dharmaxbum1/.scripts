#!/bin/bash
## by xtonousou
# simple script to automate "oh new mirrorlist, lets rank and replace" process

if [ "$EUID" -ne 0 ]
  then printf "e[31mPlease run as root\n"
  exit
fi

printf "\e[36mSpeculum by xToNouSou\n" | pv -qL 11

if [ -f /etc/pacman.d/mirrorlist.pacnew ]; then
    printf "\e[39msed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.pacnew\n"
    sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.pacnew
    printf "\e[39mrankmirrors -n 6 /etc/pacman.d/mirrorlist.pacnew > /etc/pacman.d/mirrorlist\n"
    rankmirrors -n 6 /etc/pacman.d/mirrorlist.pacnew > /etc/pacman.d/mirrorlist
    printf "\e[32mdone\n"
else
    printf "\e[31mmirrorlist.pacnew not found!\n"
fi
