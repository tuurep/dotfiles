# Set desktop 'wallpaper' as solid black color
# Note: xsetroot -solid is incompatible with picom
# which is why hsetroot is used instead
hsetroot -solid '#000000'

# Map capslock to esc
setxkbmap -option caps:escape

# Key repeat: ms, interval
xset r rate 315 25

sh ~/.config/polybar/launch.sh &
dunst &

picom -b

# Clipboard management:
# parcellite for preserving clipboard contents on
# application close, greenclip for history access
# through rofi
parcellite &
greenclip daemon &
