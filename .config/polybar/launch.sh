#!/usr/bin/env bash

# Terminate already running bar instances
killall -q -w polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybars -- automatically reload on config changes
if [ "$MONITOR_RIGHT" != "" ]; then
  MONITOR=$MONITOR_RIGHT polybar --reload ${1:-right} &
fi

if [ "$MONITOR_LEFT" != "" ]; then
  MONITOR=$MONITOR_LEFT polybar --reload ${1:-left} &
fi

if [ "$MONITOR_LAPTOP" != "" ]; then
  MONITOR=$MONITOR_LAPTOP polybar --reload ${1:-left} &
fi

echo "Bars launched..."
