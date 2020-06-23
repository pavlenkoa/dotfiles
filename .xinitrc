#!/bin/zsh

# Executing defaults in xinitrc.d
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Automatic scaling and color settings
xrandr --auto

# Second monitor on top
xrandr --output HDMI2 --auto --above eDP1

# DWM status
~/bin/dwm_status &

# Wallpaper
feh --no-fehbg --bg-fill "/home/andrew/misc/wallpapers/anime-landscape-waterfall-cloud-5k-mq-1920x1080.jpg"

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
sleep 2s && telegram-desktop &

exec dwm

