#!/bin/bash

# Default values
SAVE_TO_CSV=false
CSV_FILE="network_scan_$(date +'%Y%m%d_%H%M%S').csv"

# Parse command-line arguments
if [[ "$1" == "--csv" ]]; then
    SAVE_TO_CSV=true
    if [[ -n "$2" ]]; then
        CSV_FILE="$2"
    fi
fi

read -p "Enter the subnet to scan (e.g., 192.168.1.0/24): " SUBNET

if [[ -z "$SUBNET" ]]; then
  echo "Error: No subnet provided. Please enter a valid subnet."
  exit 1
fi

echo "Starting network scan on subnet $SUBNET..."
echo "Scanning live devices, this may take a few seconds..."

if $SAVE_TO_CSV; then
  echo "IP Address,MAC Address" > "$CSV_FILE"
fi

for i in $(seq 1 254); do
  CURRENT_IP=$(echo "$SUBNET" | sed "s/0\/24/$i/")
  ping -c 1 -W 1 "$CURRENT_IP" > /dev/null

  if [ $? -eq 0 ]; then
    MAC_ADDRESS=$(arp -n "$CURRENT_IP" | awk '/ether/ {print $3}')
    echo "Device found at $CURRENT_IP with MAC $MAC_ADDRESS"
    
    if $SAVE_TO_CSV; then
      echo "$CURRENT_IP,$MAC_ADDRESS" >> "$CSV_FILE"
    fi
  fi
done

echo "Scan complete."
if $SAVE_TO_CSV; then
  echo "Results saved to $CSV_FILE."
fi
