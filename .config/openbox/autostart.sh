#!/bin/bash

# Set desktop 'wallpaper' as solid black color
# Note: xsetroot -solid is incompatible with picom
# which is why hsetroot is used instead
hsetroot -solid '#000000'

polybar bar1 &
dunst &
picom -b
transmission-daemon

# Clipboard management:
# parcellite for preserving clipboard contents on
# application close, greenclip for history access
# through rofi
parcellite &
greenclip daemon &

# `proton-vpn-gtk-app` needs this
nm-applet &
