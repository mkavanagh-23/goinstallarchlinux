#!/usr/bin/env bash

detect_environment() {
    # check if we are on Arch linux
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [ "${ID,,}" = "arch" ]; then
            # check if we are on the install usb
            if [[ -d "/run/archiso" ]]; then
                echo "installer"
                return
            else
                echo "existing"
                return
            fi
        fi
    fi
    echo "unsupported"
    return
}

detect_t2() {
    kernel_name=$(uname -s)
    if [ "${kernel_name,,}" = "arch-t2" ]; then
        echo "t2"
        return
    fi

    echo "vanilla"
    return
}