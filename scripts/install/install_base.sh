#!/usr/bin/env bash

# Check for a network connection, if not connected check for a wireless adapter, if present run iwctl, otherwise exit with an error, prompting user to connect to a network and try again

install() {
    if [ $# -ne 1 ]; then
        echo "Usage: install [vanilla|t2]"
        return 1  # return an error code
    fi
    local installType="$1" # vanilla|t2

    if [[ "$installType" == "t2" ]]; then
        if ! net_install_t2; then
            return 1
        fi
    else
        if ! net_install_vanilla; then
            return 1
        fi
    fi
    # Install Go

    return
}