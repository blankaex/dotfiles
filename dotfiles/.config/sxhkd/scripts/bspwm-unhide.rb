#!/usr/bin/env ruby

count = `bspc query -N -n .hidden | wc -l`.to_i()

if count > 0
    node = case
        when count == 1
            `bspc query -N -n .hidden -n .sticky | tail -n1`.strip()
        when count > 1
            `bspc query -N -n .hidden -n .sticky | xargs xtitle -f "%u: %s\n" |
                rofi -m primary -dmenu -i -p "Unhide"`.split(":")[0]
    end
    exec "bspc node #{node} -g hidden=off -g sticky=off" if node
end
