#!/usr/bin/env bash

# This script provides functions to detec and return different aspects of the current environement

detect_environment() {
    # check if we are on Arch linux
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [ "${ID,,}" = "arch" ]; then
            if systemd-detect-virt -q; then
                echo "virtualized"
                return
            fi
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
    local kernel_release
    kernel_release=$(uname -r)
    shopt -s nocasematch
    if [[ "$kernel_release" == *t2* ]]; then
        echo "t2"
    else
        echo "vanilla"
    fi
    shopt -u nocasematch
    return
}