#!/bin/bash


SUBNET=$(hostname -I | awk '{print $1}' | cut -d '.' -f 1-3)
DEFAULT_LOG_FILE="network_scan_$(date +%Y%m%d_%H%M%S).csv" 


SAVE_TO_CSV=false  # Default to not saving
CUSTOM_LOG_FILE=""

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --csv) SAVE_TO_CSV=true ;;  
        --file) CUSTOM_LOG_FILE="$2"; shift ;;  
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
    shift
done


LOG_FILE="${CUSTOM_LOG_FILE:-$DEFAULT_LOG_FILE}"


if $SAVE_TO_CSV; then
    echo "Timestamp,IP Address,MAC Address" > "$LOG_FILE"
fi

echo "Starting network scan on subnet $SUBNET.0/24..."
echo "Scanning live devices, this may take a few seconds..."


for i in $(seq 1 254); do
    IP="$SUBNET.$i"
    
    ping -c 1 -W 1 $IP &> /dev/null
    
    
    if [ $? -eq 0 ]; then
        
        MAC=$(arp -n $IP | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')
        if [ -n "$MAC" ]; then
            echo "Found device: IP=$IP, MAC=$MAC"
            if $SAVE_TO_CSV; then
                echo "$(date),$IP,$MAC" >> "$LOG_FILE"
            fi
        fi
    fi
done

if $SAVE_TO_CSV; then
    echo "Network scan completed. Results saved to $LOG_FILE."
else
    echo "Network scan completed."
fi
