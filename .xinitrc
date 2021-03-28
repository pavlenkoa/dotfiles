#!/bin/zsh

# Executing defaults in xinitrc.d
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Set pointer to left arrow
xsetroot -cursor_name left_ptr

# Automatic scaling
xrandr --auto

# X11 load defaults
xrdb ~/.Xdefaults

# Monitor setup
~/bin/monitors.sh

# DWM status
#~/bin/dwm_status &

# Wallpaper
feh --no-xinerama --no-fehbg --bg-scale "/home/andrew/misc/wallpapers/full_moon.jpg"
#feh --no-fehbg --bg-fill "/home/andrew/misc/wallpapers/anime-landscape-waterfall-cloud-5k-mq-1920x1080.jpg"

# Key bindings
xmodmap ~/.Xmodmap

# Fonts
xset +fp /usr/share/fonts/X11/misc/ &
xset fp rehash &
xset -b

# Autorun
sleep 1s && google-chrome-stable --enable-features=WebUIDarkMode --force-dark-mode &
sleep 3s && thunderbird &
#sleep 4s && pavucontrol &
#sleep 2s && telegram-desktop &

exec xmonad
