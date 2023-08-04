#!/usr/bin/env ruby

require 'fileutils'

def main
  dir = ARGV.fetch(0)

  if (File.directory?(dir))
    FileUtils.cd(dir)

    symbolic_ref = `git symbolic-ref -q --short HEAD`.strip

    if symbolic_ref == ""
      # Exit without output keeps the current branch name in the bar,
      # which is nice if we're rebasing.
      exit
    end

    puts symbolic_ref
  else
    puts ""
  end
end

main
