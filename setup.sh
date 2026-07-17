#!/bin/bash

# Setup Script for Wi-Fi Security Lab


# 1. Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "[-] Please run as root (use sudo ./setup.sh)"
  exit 1
fi

echo "[+] Updating package lists..."
apt-get update -y

echo "[+] Installing core wireless security tools and packages..."
apt-get install -y \
    aircrack-ng \
    kismet \
    hostapd \
    dnsmasq \
    wireshark \
    tshark \
    iw \
    wireless-tools \
    net-tools \
    python3-pip \
    python3-scapy

# 2. Make all shell scripts executable
echo "[+] Setting executable permissions for lab scripts..."
chmod +x scripts/*.sh 2>/dev/null || chmod +x *.sh

# 3. Create required runtime directories for logs and captures
echo "[+] Creating log and capture directories..."
mkdir -p logs captures configs

# 4. Environment check
echo "[+] Verifying wireless interfaces..."
iw dev

echo "=============================================================================="
echo "[+] Setup complete! Lab environment is ready."
echo "=============================================================================="
