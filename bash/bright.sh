#!/bin/bash
# depends on xbacklight, dunst, dunstify

notify () {
    # get backlight level
    percent=$(xbacklight | cut -f1 -d ".")
    
    title="Brightness"

    # create fancy bar
    f=$((percent/10))
    e=$((10-f))
    fchars='◼◼◼◼◼◼◼◼◼◼'
    echars='◻◻◻◻◻◻◻◻◻◻'
    bar="${fchars:0:f}${echars:0:e} $percent%"
    
    ID=$(cat $HOME/.config/dunst/.dunst_brightness)
    if [ $ID -gt "0" ]
    then
        dunstify -p -r $ID "$title\n$bar" > $HOME/.config/dunst/.dunst_brightness
    else
        dunstify -p "$title\n$bar" > $HOME/.config/dunst/.dunst_brightness
    fi
}

# redirect stdout of this script to /dev/null
exec > /dev/null

case "$1" in
    up)
        xbacklight -inc 5
        ;;
    down)
        xbacklight -dec 5
        ;;
esac

notify
