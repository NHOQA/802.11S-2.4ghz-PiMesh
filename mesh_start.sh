#!/bin/bash
#this brings wlan1 up as mesh interface
#stop some processes that interfere with what we're trying to do
#systemctl stop wpa_supplicant
#systemctl stop NetworkManager
nmcli device set wlan1 managed no

systemctl enable systemd-networkd

#**************CHECK INTERFACE NAMES**************************

INTERFACE=wlan1 #This is the HaLow radio interface. Adjust if it is not already wlan one. Check using "ip a" command

#**************SET MESH NAME AND THIS NODE'S IP ADDRESS****************
MESH_NAME=natak_mesh #This must be identical for each node on the mesh
IP_ADDR=192.168.150.102/24 #This must be unique address for each node.

#**************DO NOT EDIT BELOW THIS LINE**********************************************************************************
ifconfig $INTERFACE down
sysctl -w net.ipv4.ip_forward=1
sysctl -p
iw reg set "US"
iw dev $INTERFACE set type managed
iw dev $INTERFACE set 4addr on
iw dev $INTERFACE set type mesh
iw dev $INTERFACE set meshid $MESH_NAME
iw dev $INTERFACE set channel 9
ip addr add $IP_ADDR dev $INTERFACE
ifconfig $INTERFACE up

#bridge created, IP address assigned and eth0 slaved by systemd files

#add mesh connection to bridge
ip link set $INTERFACE master br0

#delete ip from mesh node to avoid conflict
sudo ip address del $IP_ADDR dev $INTERFACE
