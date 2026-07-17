#!/usr/bin/env python3
from scapy.all import sniff, Dot11, Dot11Deauth
import time

# Configuration
INTERFACE = "wlan0mon"
THRESHOLD = 10      # Number of deauth frames
WINDOW = 5          # Seconds to monitor

deauth_count = 0
start_time = time.time()

def process_packet(packet):
    global deauth_count, start_time

    # Check if the packet is a management frame with a deauthentication subtype
    if packet.haslayer(Dot11Deauth):
        deauth_count += 1
        
        current_time = time.time()
        elapsed = current_time - start_time

        # If threshold reached within window, alert and reset
        if elapsed < WINDOW:
            if deauth_count >= THRESHOLD:
                print(f"[!] ALERT: Deauthentication flood detected! {deauth_count} frames in {elapsed:.2f}s")
                deauth_count = 0
                start_time = current_time
        else:
            # Reset window
            deauth_count = 1
            start_time = current_time

print(f"[*] Starting IDS on {INTERFACE}. Threshold: {THRESHOLD} frames / {WINDOW}s")
sniff(iface=INTERFACE, prn=process_packet, store=0)
