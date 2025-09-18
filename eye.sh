#!/bin/bash

# Eye - Simple Bash Port Scanner (Scan Common Ports by Default)


# Usage: ./eye.sh <target>

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <target>"
    exit 1
fi

TARGET=$1

# Resolve the target (either domain or IP)
if [[ $TARGET =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    # If it's an IP address, we can use it directly
    IP=$TARGET
else
    # Resolve domain to IP
    IP=$(nslookup $TARGET | grep "Address" | tail -n 1 | awk '{print $2}')
    if [ -z "$IP" ]; then
        echo "Failed to resolve domain: $TARGET"
        exit 1
    fi
    echo "Resolved domain $TARGET to IP $IP"
fi

# Eye ASCII Banner
echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo "⠀⢿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⠇"
echo "⠀⠈⢿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⠏⠀"
echo "⠀⠀⠈⢻⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣤⣶⣶⣶⣾⣿⣿⣿⣿⣿⣶⣶⣶⣦⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⠏⠀⠀"
echo "⠀⠀⠀⠀⢻⣿⣄⠀⠀⠀⠀⣀⣤⣶⣿⡿⢟⣿⣿⡿⠛⠋⠉⠀⠀⠀⠀⠈⠉⠛⠻⣿⣿⣿⠿⣿⣷⣦⣄⡀⠀⠀⠀⠀⣼⣿⠃⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⠛⠋⠀⣠⣶⣿⠿⠛⠉⢀⣴⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣷⣄⠈⠙⠻⢿⣷⣦⡀⠈⠛⠃⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⢀⣴⣿⠿⠋⠁⠀⠀⢠⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⠀⠀⠀⠀⠀⠙⣿⣧⠀⠀⠀⠉⠻⢿⣷⣄⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⣠⣾⣿⠟⠁⠀⠀⠀⠀⢠⣿⡟⠀⠀⠀⠀⠀⢀⣴⣿⠿⠿⠿⠿⠿⠿⢿⣷⣄⠀⠀⠀⠀⠀⠘⣿⣧⠀⠀⠀⠀⠀⠙⢿⣿⣦⡀⠀⠀"
echo "⠀⢀⣴⣿⠟⠁⠀⠀⠀⠀⠀⠀⣾⣿⠀⠀⠀⠀⠀⣰⣿⠟⠁⠀⠀⠀⠀⠀⠙⢿⣷⡀⠀⠀⠀⠀⢸⣿⡆⠀⠀⠀⠀⠀⠀⠘⢿⣿⣄⠀"
echo "⣠⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⡇⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣧"
echo "⠻⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⡇⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⡿"
echo "⠀⠘⢿⣷⣄⠀⠀⠀⠀⠀⠀⠀⢿⣿⠀⠀⠀⠀⠀⠹⣿⣆⠀⠀⠀⠀⠀⠀⢀⣾⡿⠁⠀⠀⠀⠀⢸⣿⠇⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⠟⠀"
echo "⠀⠀⠀⠙⢿⣷⣄⡀⠀⠀⠀⠀⠘⣿⣇⠀⠀⠀⠀⠀⠙⠿⣿⣶⣤⣤⣴⣾⣿⠟⠁⠀⠀⠀⠀⢀⣴⣿⠟⠀⣀⣤⣤⣾⣿⠟⠁⠀⠀"
echo "⠀⠀⠀⠀⠀⠙⠿⣿⣦⣀⠀⠀⠀⠙⣿⣧⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⣠⣾⡟⠁⠀⠀⢀⣠⣾⡿⠟⠁⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⠀⠈⠛⢿⣿⣦⣄⡀⠘⢿⣷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣾⣿⠟⠀⣀⣤⣾⣿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⢿⣿⣶⣽⣿⣿⣶⣤⣀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣾⣿⣿⣵⣾⣿⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠛⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠛⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo "--------------------------------------------"
echo "👁️  Eye - Common Port Scanner By 0xRayan"
echo "Scanning $IP ($TARGET) for common ports..."
echo "--------------------------------------------"

# Define common ports to scan
COMMON_PORTS=(20 21 22 23 25 53 80 110 143 443 3306 3389 8080 8081 8443)

# Port scanning with service info
for port in "${COMMON_PORTS[@]}"; do
    timeout 1 bash -c "echo > /dev/tcp/$IP/$port" 2>/dev/null
    if [ $? -eq 0 ]; then
        # Port is open, show port info if available
        case $port in
            20) service="FTP Data" ;;
            21) service="FTP Control" ;;
            22) service="SSH" ;;
            23) service="Telnet" ;;
            25) service="SMTP" ;;
            53) service="DNS" ;;
            80) service="HTTP" ;;
            110) service="POP3" ;;
            143) service="IMAP" ;;
            443) service="HTTPS" ;;
            3306) service="MySQL" ;;
            3389) service="RDP" ;;
            8080) service="HTTP Proxy" ;;
            8081) service="HTTP Proxy Alt" ;;
            8443) service="HTTPS Alt" ;;
            *) service="Unknown" ;;
        esac
        echo "Port $port is OPEN | Service: $service"
    else
        echo "Port $port is CLOSED"
    fi
done

echo "--------------------------------------------"
echo "Scan complete."
