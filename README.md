# Local Network Scanner (LNS)

**LNS** is a lightweight and efficient tool to scan your local network, detect active devices, and log their details (IP and MAC addresses). It can optionally save the results to a CSV file for future reference.

---
## Installation

1. **Clone or Download** the repository, or copy the `lns.sh` script to your system.
2. **Make the Script Executable**:
   ```bash
   chmod +x lns.sh
   ```
3. **Move to Global PATH**:
   To use `lns` as a global command, move it to `/usr/local/bin/`:
   ```bash
   sudo mv lns.sh /usr/local/bin/lns
   ```
   
## Scan and Display Results

To simply scan the network and display results in the terminal:
```bash
lns.sh
```

---

## Save Results to CSV

To save the output as a CSV file with a default timestamped filename:
```bash
lns.sh --csv
```

The results will be saved to a file like `network_scan_YYYYMMDD_HHMMSS.csv`.

---

## Save Results to a Custom CSV File

To specify a custom filename for the CSV output:
```bash
lns.sh --csv custom_log.csv
```

The results will be saved to `custom_log.csv`.

---

## Example Output

### Terminal Output
```plaintext
Enter the subnet to scan (e.g., 192.168.1.0/24): 192.168.1.0/24
Starting network scan on subnet 192.168.1.0/24...
Scanning live devices, this may take a few seconds...
Device found at 192.168.1.10 with MAC 00:1A:2B:3C:4D:5E
Device found at 192.168.1.15 with MAC 11:22:33:44:55:66
Scan complete.
Results saved to network_scan_20241129_123456.csv.
```

### CSV File Example
If you use the `--csv` option, the CSV file will look like this:
```csv
Timestamp,IP Address,MAC Address
2024-11-24 10:45:01,192.168.1.10,00:1A:2B:3C:4D:5E
2024-11-24 10:45:02,192.168.1.15,11:22:33:44:55:66
```

---

## How It Works

### Subnet Detection
The tool automatically determines your network's subnet based on your device's IP address.

### Ping Sweep
It pings all IP addresses in the subnet range (`.1` to `.254`) to identify live devices.

### MAC Address Retrieval
For each responding device, its MAC address is fetched using the `arp` command.

### Logging
Results are displayed in the terminal. If the `--csv` option is provided, the results are also saved to a CSV file.

---

## Options

| Option               | Description                                                     |
|----------------------|-----------------------------------------------------------------|
| `--csv`             | Saves output to a CSV file with a default timestamped filename. |
| `--csv <filename>`  | Saves output to a custom CSV file with the specified filename.  |

---

## Requirements

### Operating System
- Designed for Linux systems.
- Can also run on Windows using **WSL** or **Git Bash**.

### Dependencies
The script relies on the following commands:
- `ping`
- `arp`
- `awk`

---

## Notes

- This script is designed to work on most Linux distributions.
- Windows users can execute this script via **WSL** or **Git Bash**.
