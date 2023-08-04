#!/usr/bin/env ruby

require 'fileutils'

def main
  dir = ARGV.fetch(0)

  if (File.directory?(dir))
    FileUtils.cd(dir)

    symbolic_ref = `git symbolic-ref -q --short HEAD`.strip

    if symbolic_ref == ""
      puts ""
    else
      icon = (symbolic_ref == "master" || symbolic_ref == "main") ? "" : ""

      puts icon
    end
  else
    puts ""
  end
end

main
