##!/bin/zsh

#automatic scaling
xrandr --auto

#font
xset +fp /usr/share/fonts/X11/misc/ &
xset fp rehash &

xset -b

#autorun
google-chrome &
thunderbird &
#sleep 1 && apulse discord &
st -e alsamixer &

#wallpaper
hsetroot -fill "/home/andrew/wallpapers/forest.jpg"

#Defaults
export BROWSER=google-chrome &
export EDITOR=nvim &

#Touchpad click prevent
syndaemon -i 0.5 -d &

~/bin/dwm_status &

exec dwm 
