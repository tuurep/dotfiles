# Background color
xsetroot -solid "#000000" &

# Map capslock to esc
setxkbmap -option caps:escape &

# Key repeat: ms, interval
xset r rate 400 25 &

sh ~/.config/polybar/launch.sh &

picom -bC &
