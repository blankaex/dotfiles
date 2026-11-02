#!/usr/bin/env ruby

if system "ip link show ivpn > /dev/null 2>&1"
  system "sudo wg-quick down ivpn"
  notification = $?.success? ? "VPN無効" : "VPNエラー"
else
  system "dunstify -r 104 VPN接続中"
  success = system "sudo wg-quick up ivpn"
  ip = `curl -4 ifconfig.co`
  notification = success ? "-t 0 VPN有効 #{ip}" : "VPNエラー"
end

exec "dunstify -r 104 #{notification}"
