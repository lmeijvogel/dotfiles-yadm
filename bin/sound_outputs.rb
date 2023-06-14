#!/usr/bin/env ruby

require 'json'

TEST_MODE = false
VALID_SINKS = [
  "sof-soundwire Headphones",
  "sof-soundwire Speaker",
  "soundcore Space Q45"
]

def cycle
  puts "Current port: #{current_port["description"]}"

  available_ports = ports_and_sinks.select {|port_and_sink| sink_allowed?(port_and_sink[:sink]) && port_available?(port_and_sink[:port]) }

  index = available_ports.find_index {|port_and_sink| port_and_sink[:port]["name"] == current_port["name"] } || -1

  next_port_and_sink = available_ports.cycle(2).to_a[index + 1]
  next_port = next_port_and_sink[:port]
  next_sink = next_port_and_sink[:sink]

  puts "Next port: #{next_port["description"]}"

  puts next_port_and_sink[:sink]["name"]
  puts default_sink["name"]
  if next_sink["name"] != default_sink["name"]
    command = %[pactl set-default-sink #{next_sink["index"]}]

    `#{command}`
  end

  if next_port_and_sink[:sink]["ports"].count > 1
    command = %[pactl set-sink-port #{next_sink["index"]} "#{next_port["name"]}"]

    `#{command}`
  end
end

def sinks
  @sinks ||= begin
    # NOTE: pactl uses the OS-configured formatting, so if I use Dutch number formatting,
    # it will sometimes render numbers as e.g. `0,00` in the JSON, causing a parsing error.
    #
    # I don't know if there's a workaround, so I'm just setting my regional settings to us_EN.

    json = TEST_MODE ? File.read("#{ENV["HOME"]}/sinks_no_headphone.json") : `pactl --format json list sinks`

    json.gsub!("0,00", "0.00")

    JSON.parse(json)
  end
end

def ports_and_sinks
  sinks.flat_map do |sink|
    sink["ports"].select {|port| port_available?(port) }.map do |port|
      {
        port: port,
        sink: sink
      }
    end

  end
end

def available?(sink_name)
  matching_sink = sinks.find {|sink| sink["description"] == sink_name }

  return false if !matching_sink
  matching_sink["ports"].any? do |port| port_available?(port) end
end

def sink_allowed?(sink)
  available_sinks = VALID_SINKS.select {|sink_name| available?(sink_name) }

  available_sinks.include? sink["description"]
end

def port_available?(port)
  ["availability unknown", "available"].include?(port["availability"])
end

def show
  puts shorten_for_bar(current_port)
end

def default_sink
  @_default_sink ||= begin
                       default_sink_name = `pactl get-default-sink`.strip

                       sinks.find { |sink| sink["name"] == default_sink_name }
                     end
end

def current_port
  @_current_port ||= begin
                       default_sink["ports"].find {|port| port["name"] == default_sink["active_port"] }
                     end
end

def shorten_for_bar(sink)
  description = sink["description"]

  if description =~ /Headset/
    return ""
  elsif description =~ /Speaker/
    return ""

  elsif description =~ /Headphones/
    return ""
  end

  # Make the Dell 'sof-soundwire HDMI / DisplayPort 2 Output' strings a bit easier to read.
  return description.gsub(/sof-soundwire /, "").gsub(/DisplayPort (\d+) Output/, "DP \\1")
end

def move_sources_to_current
  sound_providers.each do |provider|
    `pactl move-sink-input #{provider["index"]} #{default_sink["index"]}`
  end
end

def sound_providers
  @_sound_providers ||= begin
                          JSON.parse(`pactl --format=json list sink-inputs`)
                        end
end

if ARGV[0] == "--cycle"
  cycle
elsif ARGV[0] == "--move-sources-to-current"
  move_sources_to_current
else
  show
end
