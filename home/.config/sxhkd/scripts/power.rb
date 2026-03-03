#!/usr/bin/env ruby

options = {
    "Shutdown"  =>  "systemctl poweroff",
    "Restart"   =>  "systemctl reboot",
    "Hibernate" =>  "systemctl hibernate",
    "Suspend"   =>  "systemctl suspend",
    "Logout"    =>  "bspc quit",
    "Lock"      =>  "$HOME/.config/bspwm/extensions/bsplock"
}

selection = `printf "#{options.keys.join("\\n")}" | rofi -dmenu -i -m primary -p "Power Menu"`.strip()

if options.has_key?(selection)
    exec options[selection]
end
