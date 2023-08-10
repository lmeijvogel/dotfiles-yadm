#!/usr/bin/env ruby

require 'fileutils'

def main
  type = ARGV[0]
  dir = ARGV[1]

  if dir.nil?
    puts ""
    exit
  end

  if (File.directory?(dir))
    FileUtils.cd(dir)

    symbolic_ref = `git symbolic-ref -q --short HEAD`.strip

    if type == "name"
      render_branch_name(symbolic_ref)
    else
      render_status_icon(symbolic_ref)
    end
  else
    puts ""
  end
end

def render_branch_name(symbolic_ref)
  # Exit without output keeps the current branch name in the bar,
  # which is nice if we're rebasing.
  exit if symbolic_ref == ""

  puts symbolic_ref
end

def render_status_icon(symbolic_ref)
  if symbolic_ref == ""
    puts ""
  else
    icon = (symbolic_ref == "master" || symbolic_ref == "main") ? "" : ""

    puts icon
  end
end

main
