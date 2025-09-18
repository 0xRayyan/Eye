# Eye - Port Scanner

## Description
**Eye** is a simple Bash-based port scanner designed for penetration testing and network reconnaissance. It checks a predefined list of common ports on a target IP address or domain and reports whether each port is open or closed, along with the service running on that port (e.g., HTTP, SSH, MySQL, etc.).

This tool is useful for quickly determining the availability of services on a network and can be used as part of larger network assessment tasks.

## Features
- Scans common ports like HTTP (80), HTTPS (443), SSH (22), MySQL (3306), etc.
- Reports if a port is open or closed.
- Displays the service associated with the open ports.

## Usage

1. Clone :
    ```bash
    git clone https://github.com/0xRayyan/Eye.git
    ```

2. Ensure the **Eye** script is executable:
    ```bash
    chmod +x tools/eye.sh
    ```

3. Run the **Eye** port scanner on a target domain or IP:
    ```bash
    ./tools/eye.sh <target>
    ```

   Example:
   ```bash
   ./tools/eye.sh example.com
Scanning IP: 93.184.216.34 (example.com)

Port 21 (FTP): Closed
Port 22 (SSH): Open
Port 80 (HTTP): Open
Port 443 (HTTPS): Open
Port 3306 (MySQL): Closed
