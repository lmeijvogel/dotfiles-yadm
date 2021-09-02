#!/bin/bash
$HOME/bin/mouse left

nitrogen --restore &

# The "sleep" is to (hopefully) ensure that compton is started long after all the monitor adjustments
if [ -x /usr/bin/picom ]; then
  (killall -q picom; sleep 10; /usr/bin/picom)&
elif [ -x /usr/bin/compton ]; then
  (killall -q compton ; sleep 10 ; /usr/bin/compton --config ~/.config/compton/compton.conf)&
fi

$HOME/bin/lib/start-polybar

(killall -q redshift-gtk ; sleep 10; redshift-gtk)&

# Clear previous xkbmap options
setxkbmap -option

# Only swap caps and escape if no ErgoDox is connected.
if [[ "$(lsusb | grep ErgoDox)" == "" ]]; then
  # For some reason, this has to be run *after* start-polybar, otherwise,
  # something in there will reset the caps lock keybinding to normal.

  /usr/bin/setxkbmap -option "caps:swapescape"
fi

# Make right alt the compose key
setxkbmap -option 'compose:ralt'
