#!/usr/bin/env bash

# This script serves as a base entry point for the installation process

install_gum() {
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
    mkdir -p "$log_dir"
    log_to_both info "Successful gum installation located. Starting logging..." "logfile" "$log_dir/$log_file"
}

install_package_pacman() {
    if [ $# -lt 1 ]; then
        echo "Usage: install_package [<pkgname> ...]"
        log_to_file error "Function 'install_package' called with no arguments" "argc" $#
        return 1  # return an error code
    fi
    
    # Check for missing packages
    local missing=()
    for pkg in "$@"; do
        if ! pacman -Q "$pkg" &>/dev/null; then
            log_to_file debug "Package not found. Adding to install list" "pkg" "$pkg"
            missing+=("$pkg")
        else
            log_to_file debug "Package already installed" "pkg" "$pkg"
        fi
    done

    # Install all missing packages at once
    if [ ${#missing[@]} -gt 0 ]; then
        echo "Installing missing packages: ${missing[*]}"
        log_to_file info "Installing missing packages: ${missing[*]}"
        sudo pacman -S --noconfirm "${missing[@]}" || {
            echo "Error installing packages"
            log_to_file error "Failed to install some packages"
            return 1
        }
    fi
}

install() {
    if [ $# -ne 1 ]; then
        echo "Usage: install [vanilla|t2]"
        return 1  # return an error code
    fi
    
    if ! net_install_pre; then
        return 1
    fi

    # Initialize pacman keyring and update database
    pacman -Sy

    # Install gum before installing the rest
    # This is used to facilitate logging and tui elements
    if ! install_gum; then
        return 1
    fi

    # FILESYSTEM.sh
    # 1. Partition 
    # 2. Format
    # 3. Mount

    # PACSTRAP.sh
    # 1. Rank mirrors
    # 2. Pacstrap the install (*T2 opts)
    # 3. pacman config (add T2 repo)
    # 4. Addtl packages (maybe?)
    # 5. genfstab

    # CHROOT.sh
    # 1. arch-chroot
    # 2. Set clocks
    # 3. Generate locales
    # DONE 4. Set the hostname
    # 5. Set the root pw
    # 6. Create a sudo user
    # 7. (*T2) Enable the fan daemon
    # 8. grub

    # POSTINSTALL.sh
    # 1. Copy over log file
    # 2. Build and install installer program
    # 3. Reboot

    return
}

post_install() {

    if [ $# -ne 1 ]; then
        echo "Usage: post_install [vanilla|t2]"
        return 1  # return an error code
    fi

    # Check if we are running as user/root account
    # Check if we have sudo access

    if ! net_install_post; then
        return 1
    fi

    # Initialize and update pacman
}