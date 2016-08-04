#!/bin/bash

## Displays and removes orphans.
## Cleans pacman cache/db directory.
## Optimizes database.

# Colors
R="\033[01;31m"
G="\033[01;32m"
B="\033[01;34m"

if [ "$EUID" -ne 0 ]
  then printf "${R}Please run as root\n"
  exit
fi

printf "${B}---> ${G}pacman -Rscn $(pacman -Qtdq)\n"
pacman -Rscn $(pacman -Qtdq)
printf "\n${B}---> ${G}pacman -Sc\n"
pacman -Sc
printf "\n${B}---> ${G}pacman-optimize && sync\n"
pacman-optimize && sync
printf "\n${B}---> ${G}updatedb\n"
updatedb

exit
