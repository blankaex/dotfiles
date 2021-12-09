#!/bin/sh

action=$(printf "Connect\\nDisconnect" | rofi -dmenu -i -m primary -p "VPN")

if [ "$action" = "Connect" ]; then

    if [ $(ps aux | rg -c "openvpn") -gt 1 ]; then
        notify-send "Already connected."
        exit 0
    fi

    sudo openvpn "$HOME/.ssh/client.ovpn" > "/tmp/vpn.log" 2>&1 & 

    while [ ! $(rg -c "Initialization Sequence Completed" "/tmp/vpn.log") ]; do
        sleep 1
    done

    notify-send "Connected to VPN."

elif [ "$action" = "Disconnect" ]; then

    if [ $(ps aux | rg -c "openvpn") -eq 1 ]; then
        notify-send "Not connected."
        exit 0
    fi

    sudo killall -SIGINT openvpn

    while [ ! $(rg -c "SIGINT" "/tmp/vpn.log") ]; do
        sleep 1
    done

    rm "/tmp/vpn.log"

    notify-send "Disconnected from VPN."

fi
