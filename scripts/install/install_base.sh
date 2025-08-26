#!/usr/bin/env bash

# Check for a network connection, if not connected check for a wireless adapter, if present run iwctl, otherwise exit with an error, prompting user to connect to a network and try again

go_install() {
    echo "Installing go..."
    return
}

go_build() {
    echo "Building installer program..."
    return
}

go_run() {
    echo "Running installer program..."
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
            echo "Attempting to connect to wifi via iwd"
            if ! wifi_connect; then
                echo "Failed to connect to the network. Please connect and then re-run the script"
                return 1
            fi
        fi 
    fi
    return 0
}

install_t2() {
    return
}