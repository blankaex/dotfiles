#!/usr/bin/env ruby

type = {
  "-o" => ["sinks", "sink"],
  "-i" => ["sources", "source"]
}[ARGV[0]]

devices, name = type

output = `pactl list #{devices}`.split("\n")
devices = output.select { |line| line.include?("Name: ") }
  .map { |line| line.split(": ")[1] }
devices.reject! { |device| device.end_with?(".monitor") } if name == "source"

default = `pactl get-default-#{name}`.strip
selection = `echo "#{devices.join("\n")}" | rofi -dmenu -i -m primary -p "#{name.capitalize} (#{default})"`.strip

exec "pactl set-default-#{name} #{selection}" if devices.include?(selection)
