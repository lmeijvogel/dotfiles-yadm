#!/usr/bin/env ruby

ALLOWED_PROPERTIES = %w[brightness saturation contrast gain ALL].freeze
ALLOWED_CHANGES = %w[up down reset max min]

DEVICE="/dev/video2"
DELTA = 5

def main(property, change)
  new_value = if change == "reset"
                128
              elsif change == "max"
                255
              elsif change == "min"
                0
              else
                old_value = retrieve_value(property)

                change == "up" ? [old_value + DELTA, 255].min : [0, old_value - DELTA].max
              end

  set_value(property, new_value)
end

def retrieve_value(property)
  response = `v4l2-ctl -d #{DEVICE} --get-ctrl=#{property}`

  Integer(response.split(": ")[1])
end

def set_value(property, value)
  `v4l2-ctl -d #{DEVICE} --set-ctrl=#{property}=#{value}`
end

def print_usage
  puts "Usage: #{$0} (#{ALLOWED_PROPERTIES.join("|")}) (#{ALLOWED_CHANGES.join("|")})"
end

property, change = ARGV

if !ALLOWED_PROPERTIES.include?(property)
  print_usage
  exit 1
end


if !ALLOWED_CHANGES.include?(change)
  print_usage
  exit 1
end

main(property, change)
