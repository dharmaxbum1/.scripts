#!/bin/bash
# Prints number of available AUR updates

yaourt -Qua | grep "^aur/" | tee /tmp/aurupdates | wc -l
