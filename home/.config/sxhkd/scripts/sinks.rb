#!/usr/bin/env ruby 

output = `pactl list sinks`.split("\n")
sinks = output.select{|line| line.include? "Name: "}.map{|line| line.split(": ")[1]}
selection = `echo "#{sinks.join("\n")}" | rofi -dmenu -i -m primary -p "Sink (#{`pactl get-default-sink`.strip})"`.strip

if !selection.empty? and sinks.include? selection
    exec "pactl set-default-sink #{selection}"
end
