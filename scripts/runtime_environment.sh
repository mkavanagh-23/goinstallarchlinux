#!/usr/bin/env bash

# Function to detect the current runtime environment
detect_environment() {
    echo "Detecting environment..."

    # check if we are on Arch linux
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [ "${ID,,}" = "arch" ]; then
            # check if we are on the install usb
            if [[ -d "/run/archiso" ]]; then
                echo "Running from Arch Linux installer USB (archiso environment detected)"
                return 1  # 0 = installer USB
            else
                echo "Running from existing Arch Linux installation"
                return 0  # 1 = existing installation
            fi
        fi
    fi

    echo "System not supported. Please run from an Arch Linux environment."
    return 2
}