#!/usr/bin/env ruby

if system "ip link show ivpn > /dev/null 2>&1"
  system "sudo wg-quick down ivpn"
  notification = $?.success? ? "dunstify -r 102 VPN無効" : "dunstify -r 102 VPNエラー"
else
  system "sudo wg-quick up ivpn"
  notification = $?.success? ? "dunstify -r 102 -t 0 VPN有効" : "dunstify -r 102 VPNエラー"
end

system(notification)
