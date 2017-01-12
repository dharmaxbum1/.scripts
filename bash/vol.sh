#!/bin/bash
# depends on ponymix, dunst, dunstify

notify () {
    # get volume level
    percent=$(ponymix get-volume)

    # check if muted, set title
    ponymix is-muted && title="Volume muted" || title="Volume"

    # create fancy bar
    f=$((percent/10))
    e=$((10-f))
    fchars='◼◼◼◼◼◼◼◼◼◼'
    echars='◻◻◻◻◻◻◻◻◻◻'
    bar="${fchars:0:f}${echars:0:e} $percent%"

    ID=$(cat $HOME/.config/dunst/.dunst_volume)
    if [[ "${ID}" -gt 0 ]]; then
      dunstify -p -r $ID "$title\n$bar" > $HOME/.config/dunst/.dunst_volume
    else
      dunstify -p "$title\n$bar" > $HOME/.config/dunst/.dunst_volume
    fi
}

# redirect stdout of this script to /dev/null
exec > /dev/null

case "$1" in
    up)
      ponymix increase 2%
      ponymix unmute
    ;;
    down)
      ponymix decrease 2%
      ponymix unmute
    ;;
    toggle)
      ponymix toggle
    ;;
esac

notify
