#!/usr/bin/env ruby

LAYOUT_SCRIPTS_PATH = "~/.lib/custom-commands/layouts/lennaert-Precision-5530"

available_monitors = `xrandr --listmonitors`.each_line.drop(1).map {|line| line.split[-1] }

best_script = if available_monitors.count == 1
                "laptop-only.sh"
              else
                "work-from-home-2nd-screen.sh"
              end

full_path_to_script = File.join(LAYOUT_SCRIPTS_PATH, best_script)

system(full_path_to_script)
