#!/usr/bin/env bash

# This script serves as a base entry point for the installation process

install_gum() {
    pacman -Sy
    # Check if gum is installed
    if ! command -v gum &>/dev/null; then
        echo "gum not found. Installing..."
        sudo pacman -S --noconfirm gum || {
            echo "Failed to install gum"
            return 1
        }
    else
        echo "gum is already installed."
    fi
}

install_package() {
    pacman -Sy
    if [ $# -lt 1 ]; then
        echo "Usage: install_package [<pkgname> ...]"
        return 1  # return an error code
    fi
    
    # Check for missing packages
    local missing=()
    for pkg in "$@"; do
        if ! pacman -Q "$pkg" &>/dev/null; then
            missing+=("$pkg")
        else
            echo "$pkg is already installed."
        fi
    done

    # Install all missing packages at once
    if [ ${#missing[@]} -gt 0 ]; then
        echo "Installing missing packages: ${missing[*]}"
        sudo pacman -S --noconfirm "${missing[@]}" || {
            echo "Failed to install some packages"
            return 1
        }
    fi
}

install() {
    if [ $# -ne 1 ]; then
        echo "Usage: install [vanilla|t2]"
        return 1  # return an error code
    fi
    local installType
    installType="$1" # vanilla|t2

    if [[ "$installType" == "t2" ]]; then
        if ! net_install_t2; then
            return 1
        fi
    else
        if ! net_install_vanilla; then
            return 1
        fi
    fi

    # Initialize pacman keyring and update database
    pacman -Sy

    # Install gum before installing the rest
    if ! install_gum; then
        return 1
    fi

    # Install git
    # Install Go
    # Install installer
    # Run installer

    return
}