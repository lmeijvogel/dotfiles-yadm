#!/usr/bin/env ruby

def main(lines)
  lines.each do |line|
    match = line.match /Bus \d+ Device \d+: ID ([0-9a-f]{4}):([0-9a-f]{4})/

    vendorId = match[1]
    productId = match[2]

    found_any = false
    Dir.glob("/sys/bus/usb/devices/*") do |dir|
      next if !file_contents_match?(dir, "idVendor", vendorId)
      next if !file_contents_match?(dir, "idProduct", productId)

      puts "Found #{dir}: #{File.read(File.join(dir, "product")).strip}"

      authorized_file_path = File.join(dir, "authorized")

      if (!File.exist?(authorized_file_path))
        puts "'authorized' file does not exist!"
        exit 1
      end

      [0, 1].each do |value|
        File.open(authorized_file_path, "w") do |file|
          file.write(value.to_s)
        end
      end

      found_any = true
    end

    puts "ERROR: No matching device" if !found_any
  end
end

def file_contents_match?(dir, part, expectedContents)
  path = File.join(dir, part)

  return false if !File.exist?(path)

  actualContents = File.read(path).strip

  return actualContents == expectedContents
end

lines = $stdin.read.each_line.map(&:strip)

main(lines)
