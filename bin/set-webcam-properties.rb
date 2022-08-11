#!/usr/bin/env ruby

ALLOWED_PROPERTIES = %w[brightness saturation contrast zoom_absolute].freeze
ALLOWED_CHANGES = %w[up down reset max min]

DELTA = 5

#                      brightness 0x00980900 (int)    : min=0 max=255 step=1 default=128 value=163
#                        contrast 0x00980901 (int)    : min=0 max=255 step=1 default=128 value=128
#                      saturation 0x00980902 (int)    : min=0 max=255 step=1 default=128 value=128
#  white_balance_temperature_auto 0x0098090c (bool)   : default=1 value=1
#                            gain 0x00980913 (int)    : min=0 max=255 step=1 default=0 value=0
#            power_line_frequency 0x00980918 (menu)   : min=0 max=2 default=2 value=2
#       white_balance_temperature 0x0098091a (int)    : min=2000 max=6500 step=1 default=4000 value=4926 flags=inactive
#                       sharpness 0x0098091b (int)    : min=0 max=255 step=1 default=128 value=128
#          backlight_compensation 0x0098091c (int)    : min=0 max=1 step=1 default=0 value=0
#                   exposure_auto 0x009a0901 (menu)   : min=0 max=3 default=3 value=3
#               exposure_absolute 0x009a0902 (int)    : min=3 max=2047 step=1 default=250 value=250 flags=inactive
#          exposure_auto_priority 0x009a0903 (bool)   : default=0 value=1
#                    pan_absolute 0x009a0908 (int)    : min=-36000 max=36000 step=3600 default=0 value=0
#                   tilt_absolute 0x009a0909 (int)    : min=-36000 max=36000 step=3600 default=0 value=0
#                  focus_absolute 0x009a090a (int)    : min=0 max=250 step=5 default=0 value=0 flags=inactive
#                      focus_auto 0x009a090c (bool)   : default=1 value=1
#                   zoom_absolute 0x009a090d (int)    : min=100 max=500 step=1 default=100 value=100
RANGES = {
  brightness: {
    default: 128,
    min: 0,
    max: 255,
    delta: 5
  },
  saturation: {
    default: 128,
    min: 0,
    max: 255,
    delta: 5
  },
  contrast: {
    default: 128,
    min: 0,
    max: 255,
    delta: 5
  },
  zoom_absolute: {
    default: 100,
    min: 100,
    max: 180,
    delta: 5
  }
}

def main(property, change)
  max = RANGES.dig(property, :max)
  min = RANGES.dig(property, :min)
  default = RANGES.dig(property, :default)
  delta = RANGES.dig(property, :delta)

  new_value = if change == "reset"
                default
              elsif change == "max"
                max
              elsif change == "min"
                min
              else
                old_value = retrieve_value(property)

                change == "up" ? [old_value + delta, max].min : [min, old_value - delta].max
              end

  set_value(property, new_value)
end

def retrieve_value(property)
  response = `v4l2-ctl -d #{device} --get-ctrl=#{property}`

  Integer(response.split(": ")[1])
end

def set_value(property, value)
  command = "v4l2-ctl -d #{device} --set-ctrl=#{property}=#{value}"
  puts command

  `#{command}`
end

def device
  $device ||= begin
                 lines = `v4l2-ctl --list-devices`.lines

                 webcams = lines.slice_before { |line| line !~ /\A\s+/ }

                 c920 = webcams.find { |group| group[0] =~ /C920/ }

                 c920_device = c920[1].strip
               end
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

main(property.to_sym, change)
