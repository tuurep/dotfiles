# Set desktop 'wallpaper' as solid black color
# Note: xsetroot -solid is incompatible with picom
# which is why hsetroot is used instead
hsetroot -solid '#000000'

# Map capslock to esc
setxkbmap -option caps:escape

# Key repeat: ms, interval
xset r rate 305 25

sh ~/.config/polybar/launch.sh &

picom -b &

dunst &

greenclip daemon &
