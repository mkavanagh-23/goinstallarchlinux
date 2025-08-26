#!/usr/bin/env bash

# Check for a network connection, if not connected check for a wireless adapter, if present run iwctl, otherwise exit with an error, prompting user to connect to a network and try again

install() {
    if [ $# -ne 1 ]; then
        echo "Usage: install [vanilla|t2]"
        return 1  # return an error code
    fi
    local installType="$1" # vanilla|t2

    # Install Go

    return
}

install_vanilla() {
    check_network
    status=$?
    if [ $status -eq 1 ]; then
        echo "'archlinux.org' inaccessible. Please try again later."
        return 1
    else
        if [ $status -eq 2 ]; then
            echo "Attempting to connect to WiFi via iwd"
            if ! wifi_connect_iwd; then
                echo "Failed to connect to the network. Please connect and then re-run the script"
                return 1
            fi
        fi 
    fi

    # Install logic here
    install "vanilla"

    return 0
}

install_t2() {
    check_network
    status=$?
    if [ $status -eq 1 ]; then
        echo "'archlinux.org' inaccessible. Please try again later."
        return 1
    else
        if [ $status -eq 2 ]; then
            echo "Attempting to connect to WiFi via nmcli"
            if ! wifi_connect_nm; then
                echo "Failed to connect to the network. Please connect and then re-run the script"
                return 1
            fi
        fi
    fi

    # Install logic here
    install "t2"

    return 0
}