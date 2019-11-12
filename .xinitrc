##!/bin/zsh

# Automatic scaling and color settings
xrandr --auto

#SystemdService=dunst.service

#export VDPAU_DRIVER=va_gl
#xrandr --output eDP1 --gamma 1.05:1.05:1.05
#dispwin -v ~/downloads/LP140WF1_SPK1.icm
#xrandr --output eDP1 --set "scaling mode" "Center"
#xrandr --output eDP1 --mode 1920x1080

# Key bindings
xmodmap ~/.Xmodmap

# Fonts
xset +fp /usr/share/fonts/X11/misc/ &
xset fp rehash &

xset -b
# Allow restart dwm without closing the apps
#while true; do
#    dwm >/dev/null 2>&1
#done

# Autorun
#chromium &
firefox &
thunderbird &
pavucontrol &
telegram-desktop &

# Wallpaper
hsetroot -fill "/home/andrew/etc/wallpapers/horseman2.jpg"

# Defaults
export BROWSER=google-chrome &
export EDITOR=nvim &

# Touchpad click prevent
syndaemon -i 0.5 -d &

# Notifications
sleep 1s && dunst &
#systemctl --user import-environment DISPLAY

# DWM status
~/bin/dwm_status &

# Lid sleep script
#while true
#do
#	if [[ $(< /proc/acpi/button/lid/LID/state) = *closed ]]
#	then
#		logger Lid closed
#		case $(< /sys/class/power_supply/AC/online) in
#			1)  ( [[ ! "$(pidof slock)" ]] && slock ) ;;
#			0) logger "suspending..."; systemctl suspend ;;
#		esac
#	fi
#	sleep 2
#done &

exec dwm
