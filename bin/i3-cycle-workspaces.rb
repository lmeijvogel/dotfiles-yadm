#!/usr/bin/env ruby
require 'json'

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

def focused_workspace
  workspaces.find { |ws| ws["focused"] }
end

def workspaces_on_current_output
  workspaces
    .select { |ws| ws["output"] == current_output }
end

def workspaces
  @workspaces ||= JSON.parse(`i3-msg -t get_workspaces`)
end

def current_output
  focused_workspace["output"]
end

def should_skip?(workspace)
  workspace_contains_virtualbox?(workspace["name"])
end

def workspace_contains_virtualbox?(workspace_name)
  workspace = find_workspace_in_tree(workspace_name)

  recursive(workspace) do |node|
    return true if node["name"]&.include? "[Running]"
  end

  false
end

def find_workspace_in_tree(name)
  recursive(tree) do |node|
    return node if node["name"] == name
  end

  nil
end

def recursive(node, depth = 0, ancestors = [], &block)
  yield node, depth, ancestors

  node['nodes'].each do |child_node|
    recursive(child_node, depth + 2, ancestors + [node], &block)
  end
end

def tree
  @tree ||= JSON.parse(`i3-msg -t get_tree`)
end

if ARGV.length != 1
  puts "Please only pass 'up' or 'down' as argument"
  exit 1
end

main(ARGV[0])
