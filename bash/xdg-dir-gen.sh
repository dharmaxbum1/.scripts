#!/bin/bash
echo "XDG-USER-DIRS GENERATOR SCRIPT"
echo "Insert absolute path and press [ENTER]"
echo
echo -n "--> Desktop: "
read desktop
xdg-user-dirs-update --set DESKTOP $desktop
echo -n "--> Documents: "
read docs
xdg-user-dirs-update --set DOCUMENTS $docs
echo -n "--> Downloads: "
read downloads
xdg-user-dirs-update --set DOWNLOAD $downloads
echo -n "--> Music: "
read music
xdg-user-dirs-update --set MUSIC $music
echo -n "--> Pictures: "
read pics
xdg-user-dirs-update --set PICTURES $pics
echo -n "--> Public: "
read public
xdg-user-dirs-update --set PUBLICSHARE $public
echo -n "--> Templates: "
read templates
xdg-user-dirs-update --set TEMPLATES $templates
echo -n "--> Videos: "
read vids
xdg-user-dirs-update --set VIDEOS $vids
echo "Done. Reboot to make changes."
