#!/bin/bash
# Workspace setup for Wi-Fi Security Lab

echo "[+] Creating directory structure..."
mkdir -p module-1-recon \
         module-2-cracking \
         module-3-rogue-ap/configs \
         module-3-rogue-ap/www \
         module-4-defense/kismet_alert_configs

echo "[+] Generating .gitignore to prevent pushing large pcap/cap files..."
cat << 'GITIGNORE' > .gitignore
*.pcap
*.pcapng
*.cap
*.hccapx
*.hc22000
*.txt
!module-3-rogue-ap/www/*.php
GITIGNORE

echo "[+] Creating module template files..."
touch setup.sh start_evil_twin.sh README.md
touch module-1-recon/recon_notes.md
touch module-2-cracking/cracking_commands.sh
touch module-3-rogue-ap/configs/hostapd.conf
touch module-3-rogue-ap/configs/dnsmasq.conf
touch module-3-rogue-ap/www/index.html
touch module-3-rogue-ap/www/login.php
touch module-4-defense/wpa3_enterprise.md
touch module-4-defense/deauth_detector.py

echo "[+] Setting executable permissions for scripts..."
# Added deauth_detector.py to chmod
chmod +x setup.sh start_evil_twin.sh setup_workspace.sh \
         module-2-cracking/cracking_commands.sh \
         module-4-defense/deauth_detector.py

echo "[+] Installing necessary dependencies..."
if ! command -v scapy &> /dev/null; then
    sudo apt update && sudo apt install -y python3-scapy
fi

echo "[+] Workspace setup complete!"

