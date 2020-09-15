def focused_workspace
  workspaces.find { |ws| ws["focused"] }
end

def workspaces_on_output(output_name)
  workspaces
    .select { |ws| ws["output"] == output_name }
end

def workspaces_on_current_output
  workspaces_on_output(current_output)
end

def workspaces
  @workspaces ||= JSON.parse(`i3-msg -t get_workspaces`)
end

def current_output
  focused_workspace["output"]
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
