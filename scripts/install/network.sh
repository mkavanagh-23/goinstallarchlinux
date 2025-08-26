#!/usr/bin/env bash

HOST="archlinux.org"

check_network() {
    echo "Checking internet connectivity..."

    if ping -c 1 -W 2 "$HOST" &> /dev/null; then
        echo "✅ Connected to the internet."
        return 0
    else
        if ping -c 1 -W 2 "google.com" &> /dev/null; then
            echo "✅ Connected to the internet. ❌ Failed to reach archlinux.org"
            return 1
        else
            echo "❌ Not connected to the internet"
            return 2
        fi
    fi
}

wifi_check() {
    echo "Checking for wireless adapters..."
    wireless_interfaces=$(iw dev 2>/dev/null | grep Interface | awk '{print $2}')
    if [ -z "$wireless_interfaces" ]; then
        echo "❌ No wireless adapters found."
        return 1
    else
        echo "✅ Wireless adapter found."
        return 0
    fi
}

wifi_connect() {
    if wifi_check; then
        echo "running iwctl"
        check_network
        status=$?
        if status; then
            echo "✅ WiFi successfully connected!"
            return 0
        fi
    fi
    return 1
}