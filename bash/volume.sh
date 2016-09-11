#!/bin/bash
# depends on ponymix, alsamixer, dunst and dunstify
ismuted=$(cat $HOME/.config/dunst/.dunst_mute)
if [ "$1" == "low" ]
then
 ponymix decrease 2
 TEXT=$(ponymix get-volume)
elif [ "$1" == "high" ]
then
 ponymix increase 2
 TEXT=$(ponymix get-volume)
elif [ "$1" == "mute" ]
then
 ponymix toggle
 amixer | sed '6q;d' | awk {'print $6'} | tr -d '[]' > $HOME/.config/dunst/.dunst_mute
 if [ "$ismuted" == "off" ]
 then
  TEXT="on"
 else
  TEXT="off"
 fi
else
 echo "Usage volume [low | high | mute]\n"
fi

ID=$(cat $HOME/.config/dunst/.dunst_volume)
if [ $ID -gt "0" ]
then
 dunstify -p -r $ID "Volume: $TEXT" > $HOME/.config/dunst/.dunst_volume
else
 dunstify -p "Volume: $TEXT" > $HOME/.config/dunst/.dunst_volume
fi

