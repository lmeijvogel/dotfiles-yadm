#!/bin/sh
xrandr --output DP-1 --off \
       --output HDMI-1 --primary --mode 1920x1200 --rotate normal \
       --output HDMI-2 --off
