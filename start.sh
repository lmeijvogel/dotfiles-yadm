#!/bin/bash
$HOME/bin/mouse left

# The "sleep" is to (hopefully) ensure that compton is started long after all the monitor adjustments
if [ -x /usr/sbin/picom ]; then
  (killall -wq picom; /usr/sbin/picom)&
elif [ -x /usr/bin/compton ]; then
  (killall -wq compton ; /usr/bin/compton --config ~/.config/compton/compton.conf)&
fi

$HOME/bin/lib/start-polybar

(killall -wq redshift-gtk ; redshift-gtk)&

# Clear previous xkbmap options
setxkbmap -option

# Only swap caps and escape if no ErgoDox is connected.
# I don't know why, but the ErgoDox no longer identifies by name anymore.
# This id here is what's reported by lsusb now.
if [[ "$(lsusb | grep 3297:4976)" == "" ]]; then
  # For some reason, this has to be run *after* start-polybar, otherwise,
  # something in there will reset the caps lock keybinding to normal.

  /usr/bin/setxkbmap -option "caps:swapescape"
else
  /usr/bin/setxkbmap -option
fi

# Make right alt the compose key
setxkbmap -option 'compose:ralt'

(sleep 3 ; nitrogen --restore)&
