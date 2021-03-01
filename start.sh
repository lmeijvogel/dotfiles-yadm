# Correctly position monitors
ruby ~/.lib/custom-commands/layouts/`hostname`/default.rb

$HOME/bin/mouse left

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

echo Starting polybar >>/tmp/log_start.sh
$HOME/bin/lib/start-polybar

killall -q redshift-gtk ; sleep 10; redshift-gtk &

# For some reason, this has to be run *after* start-polybar, otherwise,
# something in there will reset the caps lock keybinding to normal.
/usr/bin/setxkbmap -option "caps:swapescape"
