##!/bin/zsh

#automatic scaling
xrandr --auto

#font
xset +fp /usr/share/fonts/X11/misc/ &
xset fp rehash &

xset -b
#Allow restart dwm without closing the apps
#while true; do
#    dwm >/dev/null 2>&1
#done

#autorun
google-chrome &
thunderbird &
#sleep 1 && apulse discord &
st -e alsamixer &

#wallpaper
hsetroot -fill "/home/andrew/wallpapers/forest.jpg"

#sleep 2 && st -title "alsamixer" -e alsamixer 
#(sleep 5 && st -title "Discord" -e apulse discord ) &

#Defaults
export BROWSER=google-chrome &
export EDITOR=nvim &

#Touchpad click prevent
syndaemon -i 0.5 -d &

~/bin/dwm_status &

exec dwm 
