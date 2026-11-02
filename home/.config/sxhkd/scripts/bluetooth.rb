#!/usr/bin/env ruby

operation = {
  "-c" => "connect",
  "-d" => "disconnect"
}[ARGV[0]]

devices = {}

`bluetoothctl devices`.each_line do |line|
  line = line.strip
  next unless line.start_with?("Device ")
  _, address, name = line.split(" ", 3)
  devices[name] = address
end

selection = `echo "#{devices.keys.join("\n")}" | rofi -dmenu -i -m primary -p "#{operation.capitalize}"`.strip

unless selection.empty? || !devices.key?(selection)
  output = `bluetoothctl #{operation} #{devices[selection]}`.strip
  exec "dunstify bluetoothctl '#{output}'"
end
