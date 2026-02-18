#!/usr/bin/env ruby 

unless ARGV.empty?
  devices = {}
  for line in `bluetoothctl devices`.split("\n")
    if line.include? "Device"
      device = line.split(" ", 3)
      devices[device[2]] = device[1]
    end
  end
  selection = `echo "#{devices.keys.join("\n")}" | rofi -dmenu -i -m primary -p "#{ARGV[0].capitalize}"`.strip
  unless selection.empty?
    output = `bluetoothctl #{ARGV[0]} #{devices[selection]}`
    exec "dunstify 'bluetoothctl' '#{output}'"
  end
end
