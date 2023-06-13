#!/usr/bin/env ruby

require 'json'

VALID_DEVICES = [
  "sof-soundwire Headphones",
  "sof-soundwire Speaker",
  "soundcore Space Q45"
]

def cycle
  default_sink_name = `pactl get-default-sink`.strip

  default_sink = sinks.find { |o| o["name"] == default_sink_name }

  puts "Current sink: #{default_sink["description"]}"

  available_sinks = VALID_DEVICES.select {|sink_name| available?(sink_name) }

  index = (available_sinks.index(default_sink["description"]) || -1) + 1

  next_description = available_sinks.cycle(2).to_a[index]
  puts "Next sink: #{next_description}"

  next_sink = sinks.find { |sink| sink["description"] == next_description }

  command = %[pactl set-default-sink #{next_sink["index"]}]

  `#{command}`
end

def sinks
  @sinks ||= begin
    # NOTE: pactl uses the OS-configured formatting, so if I use Dutch number formatting,
    # it will sometimes render numbers as e.g. `0,00` in the JSON, causing a parsing error.
    #
    # I don't know if there's a workaround, so I'm just setting my regional settings to us_EN.

    json = `pactl --format json list sinks`

    json.gsub!("0,00", "0.00")

    JSON.parse(json)
  end
end

def available?(sink_name)
  matching_sink = sinks.find {|sink| sink["description"] === sink_name }

  return false if !matching_sink
  matching_sink["ports"].any? do |port|
    ["availability unknown", "available"].include?(port["availability"])
  end
end

def show
  default_sink_name = `pactl get-default-sink`.strip

  default_sink = sinks.find {|sink| sink["name"] == default_sink_name }

  short_name = shorten_for_bar(default_sink)

  click_action = "#{$0} --cycle"

  puts "%{A1:#{click_action}:}#{short_name}%{A}"
end

def shorten_for_bar(sink)
  description = sink["description"]

  if description =~ /Q45/
    return ""
  elsif description =~ /sof-soundwire Speaker/
    return ""

  elsif description =~ /sof-soundwire Headphones/
    return ""
  end

  # Make the Dell 'sof-soundwire HDMI / DisplayPort 2 Output' strings a bit easier to read.
  return description.gsub(/sof-soundwire /, "").gsub(/DisplayPort (\d+) Output/, "DP \\1")
end

if ARGV.include?("--cycle")
  cycle
else
  show
end
