# Local Network Scanner (LNS)

`LNS` is a simple and user-friendly Bash command-line tool for scanning devices on your local network. It automatically detects the local subnet, pings each device to find active IP addresses, retrieves their MAC addresses, and logs the results with timestamps. The tool offers options for saving results as a CSV file, making it convenient for network monitoring and device discovery.

**Note:** This tool is designed specifically for Linux-based systems (e.g., Raspberry Pi) and may not work natively on Windows. However, it can be run via **Windows Subsystem for Linux (WSL)** or **Git Bash**.

## Features
- **Automated Subnet Detection**: No need to configure network settings manually – `LNS` detects your local subnet automatically.
- **Active Device Detection**: Pings each IP in the subnet to check for active devices.
- **MAC Address Retrieval**: Logs the MAC address for each active IP found.
- **CSV Output Option**: Saves results in a timestamped CSV file when specified.

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

## Usage

### Basic Scan
To perform a network scan and output results to the console:
```bash
lns
```

### Save Results to CSV
To save the output as a CSV file:
```bash
lns --csv
```

### Save Results to a Custom CSV File
To specify a custom filename for the CSV output:
```bash
lns --csv --file custom_log.csv
```

### Example Output
If you use the `--csv` option, the CSV file (e.g., `network_scan_YYYYMMDD_HHMMSS.csv`) will look like this:

```
Timestamp,IP Address,MAC Address
2024-11-24 10:45:01,192.168.1.10,00:1A:2B:3C:4D:5E
2024-11-24 10:45:02,192.168.1.15,11:22:33:44:55:66
```

## How It Works
1. The tool automatically detects your subnet based on your device's IP address.
2. It pings each IP address in the subnet from `.1` to `.254`.
3. If a device responds, `LNS` retrieves its MAC address using `arp`.
4. The IP, MAC address, and timestamp are logged to the console or saved in a CSV file, if specified.

## Options
- **`--csv`**: Saves output to a CSV file with a default timestamped filename.
- **`--file <filename>`**: Specifies a custom filename for the CSV output.

## Requirements
- **Linux-based system**: This tool is designed to work on Linux systems (e.g., Raspberry Pi).
- **Windows**: The tool might not work natively on Windows. However, you can run it via **Windows Subsystem for Linux (WSL)** or **Git Bash terminal**.
- **`ping` and `arp`**: Required utilities, which are available by default on most Linux distributions.

---
