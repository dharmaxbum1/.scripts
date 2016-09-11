#!/bin/bash
#
# @title Chmod Wordpress
# ------------------------------------------------------------------------------------------
# @author Myles McNamara
# @date 02/10/2013
# @version 1.0
# @source http://github.com/tripflex
# @description This script will chmod all directories to 755 and files to 644. It will only chmod files and directories that are not those permissions already.
# ------------------------------------------------------------------------------------------
# @usage ./chmodwp <path>
# ------------------------------------------------------------------------------------------
# @copyright Copyright (C) 2013  Myles McNamara
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
# ------------------------------------------------------------------------------------------

if [ "$#" -lt 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ] || [[ $1 == -* ]]; then
 	echo "Usage: $0 <path>" >&2
 	exit
fi
clear
echo "Changing permissions as follows"
echo "    directory permission 755"
echo "    file permissions 644"
echo "---------------------------------------------------------"
echo "Only directories NOT matching 755, and files NOT matching 644 will be chmod and output below"
echo "---------------------------------------------------------"
find $1 -type d ! -perm 0755 -print -exec chmod 755 {} \;
find $1 -type f ! -perm 0644 -print -exec chmod 644 {} \;
echo "---------------------------------------------------------"	
echo "Permission change complete."
echo "If no file paths are shown above, all files and directories are correct already."
echo "---------------------------------------------------------"
