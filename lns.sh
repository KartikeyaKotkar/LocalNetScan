#!/bin/bash

read -p "Enter the subnet to scan (e.g., 192.168.1.0/24): " SUBNET

if [[ -z "$SUBNET" ]]; then
  echo "Error: No subnet provided. Please enter a valid subnet."
  exit 1
fi

# Generate a unique filename for the CSV
CSV_FILE="network_scan_$(date +'%Y%m%d_%H%M%S').csv"

echo "Starting network scan on subnet $SUBNET..."
echo "Scanning live devices, this may take a few seconds..."

echo "IP Address,MAC Address" > "$CSV_FILE"

for i in $(seq 1 254); do
  CURRENT_IP=$(echo "$SUBNET" | sed "s/0\/24/$i/")
  ping -c 1 -W 1 "$CURRENT_IP" > /dev/null

  if [ $? -eq 0 ]; then
    MAC_ADDRESS=$(arp -n "$CURRENT_IP" | awk '/ether/ {print $3}')
    if [[ ! -z "$MAC_ADDRESS" ]]; then
      echo "$CURRENT_IP,$MAC_ADDRESS" >> "$CSV_FILE"
      echo "Device found at $CURRENT_IP with MAC $MAC_ADDRESS"
    fi
  fi
done

echo "Scan complete. Results saved to $CSV_FILE."
