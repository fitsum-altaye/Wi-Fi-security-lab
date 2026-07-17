# WPA3-Personal (SAE) Configuration
interface=wlan0
driver=nl80211
ssid=Nana_new
hw_mode=g
channel=11

# 1. Enable RSN framework (WPA2/WPA3 architecture)
wpa=2

# 2. Enforce WPA3 SAE key management (disables WPA2 PSK)
wpa_key_mgmt=SAE

# 3. Use CCMP/AES cipher
rsn_pairwise=CCMP

# 4. Enforce Protected Management Frames (MANDATORY for WPA3)
ieee80211w=2

# 5. Password for SAE clients
wpa_passphrase=2026$LienT@5s
