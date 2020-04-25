#!/usr/bin/env ruby

$LOAD_PATH << File.join(__dir__, "lib")

require 'json'
require 'i3_workspace_helpers'

def main(up_or_down)
  next_workspace_name = next_workspace(up_or_down)["name"]

  `i3-msg workspace "#{next_workspace_name}"`
end

def next_workspace(direction)
  next_workspaces = next_workspaces(direction)

  # Nothing to switch, so just return the current one
  return focused_workspace if next_workspaces.count < 2

  current_index = next_workspaces.index(focused_workspace)

  # A #cycle feels a bit more robust than current + 1 % length
  next_workspaces.cycle(2).find.with_index { |ws, i| i > current_index && !should_skip?(ws) }
end

def next_workspaces(direction)
  if direction == "down"
    workspaces_on_current_output.reverse
  else
    workspaces_on_current_output
  end
end

def should_skip?(workspace)
  workspace_contains_virtualbox?(workspace["name"])
end

def workspace_contains_virtualbox?(workspace_name)
  workspace = find_workspace_in_tree(workspace_name)

  recursive(workspace) do |node|
    return true if node["name"]&.include? "htop"
  end

  false
end

if ARGV.length != 1
  puts "Please only pass 'up' or 'down' as argument"
  exit 1
end

main(ARGV[0])
