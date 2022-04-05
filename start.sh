#!/bin/bash

# Button config is now handled by Plasma
# $HOME/bin/mouse left

# The "sleep" is to (hopefully) ensure that compton is started long after all the monitor adjustments
if [ -x /usr/sbin/picom ]; then
  (killall -wq picom; /usr/sbin/picom)&
elif [ -x /usr/bin/compton ]; then
  (killall -wq compton ; /usr/bin/compton --config ~/.config/compton/compton.conf)&
fi

$HOME/bin/lib/start-polybar

(killall -wq redshift-gtk ; redshift-gtk)&

# Set dvorak keyboard layout
/usr/bin/setxkbmap dvorak

# Clear previous xkbmap options
/usr/bin/setxkbmap -option

# Swap caps lock and escape
/usr/bin/setxkbmap -option "caps:swapescape"

# Make right alt the compose key
/usr/bin/setxkbmap -option 'compose:ralt'

(sleep 3 ; nitrogen --restore)&
