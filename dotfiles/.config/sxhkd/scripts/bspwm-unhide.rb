#!/bin/env ruby

count = `bspc query -N -n .hidden | wc -l`.to_i()

if count > 0
    if count > 1
        node = `bspc query -N -n .hidden -n .sticky |
            xargs xtitle -f "%s: %u\n" |
            rofi -m primary -dmenu -i -p "Unhide" |
            sed 's/.*: //' |
            xargs printf "0x%x\n"`.strip()
    else
        node = `bspc query -N -n .hidden -n .sticky | tail -n1`.strip()
    end
    exec "bspc node #{node} -g hidden=off -g sticky=off"
end
