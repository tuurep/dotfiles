#!/bin/bash

# Set desktop 'wallpaper' as solid black color
# Note: xsetroot -solid is incompatible with picom
# which is why hsetroot is used instead
hsetroot -solid '#000000'

polybar bar1 &
dunst &
picom -b
transmission-daemon

# lightdm greeter as lock screen
# only on keybind
light-locker --no-late-locking --no-lock-on-suspend --no-lock-on-lid \
             --no-idle-hint --lock-after-screensaver=0 &

# Clipboard management:
# parcellite for preserving clipboard contents on
# application close, greenclip for history access
# through rofi
parcellite &
greenclip daemon &
