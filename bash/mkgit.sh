#!/bin/bash

if [ -z "$1" ]
then
	echo -e "\nCreates new git repository.\n\nSyntax: $(basename $0) <name>\n"
	exit 1
fi

which git >/dev/null 2>&1
if [ $? -eq 1 ]
then
	echo "Installing git-core package..."
	sudo pacman -S git-core
fi

which git >/dev/null 2>&1
if [ $? -eq 1 ]
then
	echo -e "ERROR: git is not installed!\n"
	exit 1
fi

if [ -d "$1.git" ]
then
	echo -e "Invalid folder: $1.git"
	exit 1
else
	mkdir "$1.git"
	cd "$1.git"
	git --bare init
fi

echo -e "\nDone.\n"

exit 0
