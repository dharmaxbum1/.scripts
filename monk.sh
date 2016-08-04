#!/bin/bash

## Displays and removes orphans.
## Cleans pacman cache/db directory.
## Optimizes database.

if [ "$EUID" -ne 0 ]
  then printf "\e[31mPlease run as root\n"
  exit
fi

pacman -Rscn $(pacman -Qtdq)
pacman -Sc
pacman-optimize && sync
updatedb

exit
