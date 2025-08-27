#!/usr/bin/env bash

# This script handles network setup on an Arch machine

TEST_HOST="archlinux.org"

check_network() {
    echo "Checking internet connectivity..."

    if ping -c 1 -W 2 "$TEST_HOST" &> /dev/null; then
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

wifi_connect_iwd() {
    if wifi_check; then
        echo
        echo "Please connect to Wifi and then enter 'exit'"
        echo "https://wiki.archlinux.org/title/Iwd#Connect_to_a_network"
        echo
        iwctl
        check_network
        local status=$?
        if [ $status -eq 0 ]; then
            echo "✅ WiFi successfully connected!"
            return 0
        fi
    fi
    return 1
}

wifi_connect_nm() {
    if wifi_check; then
        nmcli
        check_network
        local status=$?
        if [ $status -eq 0 ]; then
            echo "✅ WiFi successfully connected!"
            return 0
        fi
    fi
    return 1
}

net_install_post() {
    echo "Starting 'net_install_post'"
    check_network
    local status=$?
    if [ $status -eq 1 ]; then
        echo "'archlinux.org' inaccessible. Please try again later."
        return 1
    elif [ $status -eq 2 ]; then
        echo "Attempting to connect to WiFi via nmcli"
        echo
        if ! wifi_connect_nm; then
            echo "Failed to connect to the network. Please connect and then re-run the script"
            return 1
        fi
    fi 

    return 0
}

net_install_pre() {
    echo "Starting 'net_install_pre'"
    check_network
    local status=$?
    if [ $status -eq 1 ]; then
        echo "'archlinux.org' inaccessible. Please try again later."
        return 1
    elif [ $status -eq 2 ]; then
        echo "Attempting to connect to WiFi via iwctl"
        echo
        if ! wifi_connect_iwd; then
            echo "Failed to connect to the network. Please connect and then re-run the script"
            return 1
        fi
    fi

    return 0
}