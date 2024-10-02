#!/usr/bin/env ruby

class NotConnected < StandardError ; end

HEADSET = "handsfree_head_unit"
HIFI = "a2dp_sink"

class BluetoothDevice
  def initialize(name)
    @name = name
  end

  def show
    if connected?
      disconnect_action = "#{$0} --disconnect"
      toggle_action = "#{$0} --toggle"

      puts "%{A1:#{disconnect_action}:} %{A}%{A1:#{toggle_action}:}#{profile_description}%{A}"
    else
      connect_action = "#{$0} --connect"
      puts "%{A1:#{connect_action}:}%{A}"
    end
  end

  def toggle
    return if !connected?

    new_profile = profile_id == HEADSET ? HIFI : HEADSET

    system("pacmd", "set-card-profile", pa_device_index, new_profile)
  rescue StandardError => e
    puts "Error! #{e.message}"
    puts e.backtrace
    exit 1
  end

  def connect
    if connected?
      puts "Already connected!"
      exit 1
    end

    `bluetoothctl connect #{mac_address}`
  end

  def disconnect
    if !connected?
      puts "Not connected!"
      exit 1
    end

    `bluetoothctl disconnect #{mac_address}`
  end


  def profile_id
    @profile_id ||= begin
                   regex_pattern = /^active profile: <([^>]*)>/

                   entry = device_entry.grep(regex_pattern)[0]

                   return nil if entry.nil?

                   entry.match(regex_pattern)[1]
                 end
  end

  def pa_device_index
    @pa_device_index ||= begin
                        index_matches = device_entry[0].match(/index: (\d+)/)

                        index_matches[1]
                      end
  end

  private def device_entry
    @device_entry ||= begin
                        output = `pacmd list-cards`

                        entries = output.each_line.map(&:strip).slice_before(/\A\s*index:/)

                        result = entries.find do |entry|
                          entry.any? { |line| line =~ /device.description = "#{@name}"/ }
                        end

                        raise NotConnected unless result

                        result
                      end
  end

  private def connected?
    output = `pacmd list-cards`

    entries = output.each_line.map(&:strip).slice_before(/\A\s*index:/)

    return entries.any? do |entry|
      entry.any? { |line| line =~ /device.description = "#{@name}"/ }
    end
  end

  private def mac_address
    @_mac_address ||= begin
                        devices = `bluetoothctl devices`

                        devices.lines.grep(/#{@name}/)[0].split(/\s+/)[1]
                      end
  end

  def profile_description
    {
      HEADSET => "Headset",
      HIFI => "HiFi"
    }[profile_id]
  end

end

action = ARGV.fetch(0)

device = BluetoothDevice.new("soundcore Space Q45")

case action
when "--toggle"
  device.toggle
when "--connect"
  device.connect
when "--disconnect"
  device.disconnect
when "--show"
  device.show
else
  puts "Invalid argument #{action}"
end
