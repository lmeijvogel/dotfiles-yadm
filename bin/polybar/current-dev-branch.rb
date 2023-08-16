#!/usr/bin/env ruby

require 'fileutils'

def main
  type = ARGV[0]
  dir = ARGV[1]

  if type != "name" && type != "icon"
    $stderr.puts usage
    puts ""
    exit
  end

  if dir.nil?
    $stderr.puts usage
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

  story_name, description = split(symbolic_ref)

  desired_length = 25

  # I want to save at least one char and truncating adds 3, so 4.
  if description.length - 4 > desired_length
    puts truncate(symbolic_ref, desired_length)
  else
    puts symbolic_ref
  end
end

def truncate(ref, desired_length)
  story_name, description = split(ref)

  return story_name + "-" + description[0..desired_length/2] + "..." + description[-desired_length/2..-1]
end

def split(ref)
  parts = %r[(\w+/\d+)-(.*)].match(ref)

  story_name = parts[1]
  description = parts[2]

  [story_name, description]
end

def render_status_icon(symbolic_ref)
  if symbolic_ref == ""
    puts ""
  else
    icon = (symbolic_ref == "master" || symbolic_ref == "main") ? "" : ""

    puts icon
  end
end

def usage
  <<~USAGE
    Usage:

      #{$0} (name|icon) <directory>
  USAGE
end
main
