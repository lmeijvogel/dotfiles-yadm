#!/bin/bash

# Button config is now handled by Plasma
# $HOME/bin/mouse left

# The "sleep" is to (hopefully) ensure that compton is started long after all the monitor adjustments
if [ -x /usr/sbin/picom ]; then
  (killall -wq picom; sleep 5 ; /usr/sbin/picom)&
elif [ -x /usr/bin/compton ]; then
  (killall -wq compton ; sleep 5 ; /usr/bin/compton --config ~/.config/compton/compton.conf)&
fi

(killall -wq redshift-gtk ; redshift-gtk)&

# Clear previous xkbmap options
/usr/bin/setxkbmap -option

# Swap caps lock and escape
/usr/bin/setxkbmap -option "caps:swapescape"

# Make right alt the compose key
/usr/bin/setxkbmap -option 'compose:ralt'

(sleep 3 ; nitrogen --restore)&

if [[ "$(hostname)" = "lennaert-Precision-5530" ]]; then
  # Set default output to built-in speakers
  pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo

  # Set default source to Trust microphone, if it's connected.
  if [[ "$(pactl list short sources | grep Trust_GXT)" != "" ]]; then
    pactl set-default-source alsa_input.usb-MUSIC-BOOST_Trust_GXT_242_Microphone-00.mono-fallback
  fi
fi

(sleep 2 ; $HOME/bin/lib/start-polybar &)
