# Correctly position monitors
ruby ~/.lib/custom-commands/layouts/`hostname`/default.rb

$HOME/bin/mouse left

$HOME/bin/start-polybar

nitrogen --restore &

if [ -x /usr/bin/picom ]; then
  echo Exists
  /usr/bin/picom &
fi

# For some reason, this has to be run *after* start-polybar, otherwise,
# something in there will reset the caps lock keybinding to normal.
/usr/bin/setxkbmap -option "caps:swapescape"
