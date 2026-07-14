#!/bin/bash

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "[-] Please run as root (use sudo)"
  exit 1
fi

echo "[+] Setting up network interface wlan0..."
ip link set wlan0 down
ip addr flush dev wlan0
ip addr add 192.168.1.1/24 dev wlan0
ip link set wlan0 up

echo "[+] Starting dnsmasq (DHCP & DNS Redirect)..."
dnsmasq -C module-3-rogue-ap/dnsmasq.conf

echo "[+] Starting PHP Web Server on port 80..."
php -S 192.168.1.1:80 -t module-3-rogue-ap/www/ &

echo "[+] Starting hostapd Rogue Access Point..."
echo "[!] Press Ctrl+C to stop all services."
hostapd module-3-rogue-ap/hostapd.conf

# Cleanup on exit
echo "[+] Cleaning up services..."
killall dnsmasq php 2>/dev/null
systemctl restart NetworkManager
