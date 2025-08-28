#!/usr/bin/env bash

set_time() {
    set_timezone

    # TODO:
    # Ask for localtime vs utc
    # hwclock --systohc
    # setup ntp
}

set_timezone() {
    local region=""
    local city=""
    
    # Prompt the user for their Region
    while [ -z "$region" ]; do
        region=$(find /usr/share/zoneinfo -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | gum filter --header "Select Your Region")
    done

    # Prompt the user for their City
    while [ -z "$city" ]; do
        city=$(find /usr/share/zoneinfo/$region -mindepth 1 -maxdepth 1 \( -type f -o -type l \) -printf "%f\n" | gum filter --header "Select Your City")
    done

    # Set the timezone
    echo "ln -sf /usr/share/zoneinfo/$region/$city /etc/localtime"
    printf "Timezone set to: %s/%s\n" "$region" "$city"
}