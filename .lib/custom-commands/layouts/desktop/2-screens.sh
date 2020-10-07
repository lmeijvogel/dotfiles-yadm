#!/bin/sh
xrandr --output DP1 --mode 1680x1050 --pos 0x0 --rotate normal \
       --output HDMI1 --primary --mode 1920x1200 --pos 1680x0 --rotate normal \
       --output HDMI2 --off
