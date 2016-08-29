#!/bin/sh
# Prints number of available PACMAN updates

checkupdates | tee /tmp/pacmanupdates | wc -l
