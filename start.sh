# Correctly position monitors
ruby ~/.lib/custom-commands/layouts/`hostname`/default.rb

$HOME/bin/mouse left

$HOME/bin/start-polybar

nitrogen --restore &

# The "sleep" is to (hopefully) ensure that compton is started long after all the monitor adjustments
if [ -x /usr/bin/picom ]; then
  killall -q picom
  sleep 10

  /usr/bin/picom &
elif [ -x /usr/bin/compton ]; then
  killall -q compton
  sleep 10

  /usr/bin/compton --config ~/.config/compton/compton.conf &
fi

# For some reason, this has to be run *after* start-polybar, otherwise,
# something in there will reset the caps lock keybinding to normal.
/usr/bin/setxkbmap -option "caps:swapescape"
