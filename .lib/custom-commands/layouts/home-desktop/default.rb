#!/usr/bin/env ruby

LAYOUT_SCRIPTS_PATH = "~/.lib/custom-commands/layouts/home-desktop"

available_monitors = `xrandr --listmonitors`.each_line.drop(1).map {|line| line.split[-1] }

best_script = if available_monitors.count == 1
                "1-screen.sh"
              else
                "2-screens.sh"
              end

full_path_to_script = File.join(LAYOUT_SCRIPTS_PATH, best_script)

system(full_path_to_script)
