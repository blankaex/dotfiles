#!/usr/bin/env ruby 

devices = {}
for line in `bluetoothctl devices`.split("\n")
  device = line.split(" ", 3)
  devices[device[2]] = device[1]
end
selection = `echo "#{devices.keys.join("\n")}" | rofi -dmenu -i -m primary -p "Device"`.strip
output = `bluetoothctl connect #{devices[selection]}`
exec "dunstify 'bluetoothctl' '#{output}'"
