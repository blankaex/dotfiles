#!/bin/ruby 

log = "/tmp/vpn.log"
action = `printf "Connect\\nDisconnect" | rofi -dmenu -i -m primary -p "VPN"`.strip

if action == "Connect"

    exec("notify-send 'Already connected'") if `ps aux | rg -c "openvpn"`.to_i > 2

    fork do
        `sudo openvpn "$HOME/.ssh/client.ovpn" > "#{log}" 2>&1`
    end

    while not `rg -c "Initialization Sequence Completed" "#{log}"`.to_i
        sleep(1)
    end

    exec("notify-send 'Connected'")

elsif action == "Disconnect"

    exec("notify-send 'Not connected'") if `ps aux | rg -c "openvpn"`.to_i <= 2

    system("sudo killall -SIGINT openvpn")
    while not `rg -c "SIGINT" "#{log}"`.to_i
        sleep(1)
    end

    system("rm '#{log}'")

    exec("notify-send 'Disconnected'")

end
