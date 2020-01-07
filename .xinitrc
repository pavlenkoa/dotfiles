##!/bin/zsh

# Automatic scaling and color settings
xrandr --auto

# DWM status
~/bin/dwm_status &

# Notifications
sleep 1s && dunst &

# Wallpaper
feh --no-fehbg --bg-scale '/home/andrew/misc/wallpapers/mandalorian/mandalorian_cave.jpg'

# Touchpad click prevent
syndaemon -i 0.5 -d &

# Key bindings
xmodmap ~/.Xmodmap

# Fonts
xset +fp /usr/share/fonts/X11/misc/ &
xset fp rehash &
xset -b

# Autorun
chromium &
thunderbird &
pavucontrol &
sleep 1s && telegram-desktop &

exec dwm
