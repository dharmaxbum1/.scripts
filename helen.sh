#!/bin/bash
# by xtonousou
# from nixcraft with some modifications :D
# Simple script to print the following in a directory
#
# file1
# file2
# [DIR] test/
# Total regular files : 7
# Total directories : 4
# Total symbolic links : 0
# Total size of regular files : 2940
#
W="\033[01;37m"
B="\033[01;34m"
R="\033[01;31m"
G="\033[01;32m"
rf=0
dir=0
syml=0
totsize=0
output=""
for f in *
do
	if [ -f $f ]
	then
		output=$f
		((rf++))
		size=$(ls -l "${f}" | awk '{print $5}')
		totsize=$((totsize+size))
	fi
	if [ -d $f ]
	then
		output="[DIR] $f/"
		((dir++))
	fi
	if [ -L $f ]
	then
		output="[LINK] $f@"
		((syml++))
	fi
	echo $output
done
printf "${W}Total regular files : $rf\n"
printf "${B}Total directories : $dir\n"
printf "${R}Total symbolic links : $syml\n"
printf "${G}Total size of regular files : $totsize\n"
