# 802.11S-2.4ghz-PiMesh

####this is to create a wifi mesh node on a pi zero 2 running bookworm and an external wifi dongle#######

create virtual interface for wlan0. keep wlan0 for hotspot and wlan0_ap will be bridged with wlan1 (mesh interface)
- install hostapd
- create virtual interface "wlan0_ap" with the command "sudo iw dev wlan0 interface add wlan0_ap type __ap"
- create/edit /etc/hostapd/hostapd.conf
- point hostapd default /etc/default/hostapd at your config file, add line "DAEMON_CONF="/etc/hostapd/hostapd.conf"
- create /etc/systemd/network/br0.netdev
- create /etc/systemd/network/br0.network
- create /etc/systemd/network/wlan0_ap.network
- sudo systemctl enable hostapd
- sudo systemctl start hostapd
- reboot




RPi mesh network on 2.4ghz

During the work to get the Teledatics TD-XPAH sub-ghz adapters I ran some testing to troubleshoot the commands used to create a mesh network.

As mentioned before I am no networking guy so this took a few attempts. Figured I'd leave this here in case someone else may find it useful. This is pretty bare bones and doesn't have any interfaces bridged to the mesh point. but should be a decent starting point. This was done using Alfa AWUS036ACM adapters on pi 4's running raspbian bookworm
