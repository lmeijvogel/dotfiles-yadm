#!/usr/bin/env bash

# Terminate already running bar instances
killall -q -w polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

MONITORS=`xrandr | grep " connected" | awk '{ print $1; }'`

for monitor in $MONITORS
do
  MONITOR=$monitor polybar --reload bottom &
done

echo "Bars launched..."
