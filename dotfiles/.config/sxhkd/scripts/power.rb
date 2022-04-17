#!/bin/env ruby

options = {
    "Shut Down" =>  "systemctl poweroff",
    "Restart"   =>  "systemctl reboot",
    "Hibernate" =>  "systemctl hibernate",
    "Logout"    =>  "bspc quit",
    "Lock"      =>  "$HOME/.config/sxhkd/scripts/lock.rb"
}

selection = `printf "#{options.keys.join("\\n")}" | rofi -dmenu -i -m primary -p "Power Menu"`.strip()

if options.has_key?(selection)
    exec options[selection]
end
