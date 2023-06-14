#!/usr/bin/env /bin/bash

# Terminate already running bar instances
killall -q -w polybar

MONITORS=`xrandr | grep " connected" | awk '{ print $1; }'`

for monitor in $MONITORS
do
  MONITOR=$monitor polybar --reload bottom &
done

echo "Bars launched..."
