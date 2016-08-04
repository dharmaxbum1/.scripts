#!/bin/bash

## Displays and removes orphans.
## Cleans pacman cache/db directory.
## Optimizes database.

pacman -Rscn $(pacman -Qtdq)
pacman -Sc
pacman-optimize && sync
updatedb

exit 1
