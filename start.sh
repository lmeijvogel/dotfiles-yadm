# Correctly position monitors
ruby ~/.lib/custom-commands/layouts/`hostname`/default.rb

$HOME/bin/mouse left

$HOME/bin/start-polybar

nitrogen --restore &

# For some reason, this has to be run *after* start-polybar, otherwise,
# something in there will reset the caps lock keybinding to normal.
/usr/bin/setxkbmap -option "caps:swapescape"
