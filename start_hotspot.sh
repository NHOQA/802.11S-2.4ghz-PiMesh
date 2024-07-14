#!/bin/bash
# this goes in /usr/local/bin
# Wait for the network to be ready
sleep 10

# Create a new virtual interface if it doesn't already exist
if ! iw dev wlan0 interface add wlan0_ap type __ap 2>/dev/null; then
    echo "wlan0_ap interface already exists or failed to create"
fi

# Bring up the interface
if ! ip link set wlan0_ap up; then
    echo "Failed to bring up wlan0_ap interface"
    exit 1
fi

# Start the hostapd service
if ! systemctl start hostapd; then
    echo "Failed to start hostapd"
    exit 1
fi
