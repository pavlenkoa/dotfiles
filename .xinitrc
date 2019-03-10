##!/bin/zsh

#automatic scaling and color settings
xrandr --auto
#xrandr --output eDP1 --gamma 1.05:1.05:1.05
#dispwin -v ~/downloads/LP140WF1_SPK1.icm

#xmodmap keybindings
xmodmap ~/.Xmodmap

#font
xset +fp /usr/share/fonts/X11/misc/ &
xset fp rehash &

xset -b
#Allow restart dwm without closing the apps
#while true; do
#    dwm >/dev/null 2>&1
#done

#autorun
chromium &
thunderbird &
#sleep 1 && apulse discord &
st -e alsamixer &

#wallpaper
hsetroot -fill "/home/andrew/wallpapers/mountains.jpg"

#sleep 2 && st -title "alsamixer" -e alsamixer 
#(sleep 5 && st -title "Discord" -e apulse discord ) &

#Defaults
export BROWSER=google-chrome &
export EDITOR=nvim &

#Touchpad click prevent
syndaemon -i 0.5 -d &

~/bin/dwm_status &

# lid sleep
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
