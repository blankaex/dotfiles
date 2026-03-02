#!/usr/bin/env ruby

nodes = `bspc query -N -n .hidden -n .sticky | xargs xtitle -f "%u: %s\n"`.split("\n")

nodes.reject! do |i| [
      "共有しています。",
      "Screen Sharing Tracker"
    ].any? { |p| i.include?(p) }
end

if nodes.length == 1
  exec "bspc node #{nodes[0].split(':')[0]} -g hidden=off -g sticky=off"
elsif nodes.length > 1
  node = `printf \"#{nodes.join("\n")}\" | rofi -m primary -dmenu -i -p "Unhide"`
  exec "bspc node #{node.split(':')[0]} -g hidden=off -g sticky=off" if node
end
