#!/bin/sh
xrandr --output DP1 --off \
       --output HDMI1 --primary --mode 1920x1200 --rotate normal \
       --output HDMI2 --off
