#!/bin/bash

mon_count=$(xrandr | grep -c " connected ")
if [[ $mon_count -gt 1 ]]; then
    xrandr --output eDP1 --off --output DP1 --mode 1920x1200 --pos 0x325 --rotate normal --rate 75 --output DP2 --off --output HDMI1 --off --output HDMI2 --primary --mode 1920x1200 --pos 1920x0 --rotate right --rate 75 --output VIRTUAL1 --off && feh --no-xinerama --no-fehbg --bg-scale "/home/andrew/misc/wallpapers/full_moon.jpg"
fi
