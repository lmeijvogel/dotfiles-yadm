#!/usr/bin/env ruby

$LOAD_PATH << File.join(__dir__, "lib")

require 'json'
require 'i3_workspace_helpers'

def main(direction:)
  next_index = current_window_index + (direction == "up" ? 1 : -1)

  next_window = windows_in_workspace.to_a[next_index % windows_in_workspace.length]

  # puts windows_in_workspace.to_json
  `i3-msg '[con_id="#{next_window["id"]}"]' focus`
end

def windows_in_workspace
  @_windows_in_workspace ||= begin
                               result = []

                               recursive(focused_workspace_in_tree) do |node|
                                 result << node if node["nodes"].empty?
                               end

                               result
                             end


end

def current_window_index
  windows_in_workspace.find_index { |window| window["focused"] }
end

def focused_workspace_in_tree
  @_focused_workspace_in_tree ||= find_workspace_in_tree(focused_workspace["name"])
end


main(direction: ARGV[0])
