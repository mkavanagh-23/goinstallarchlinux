#!/usr/bin/env bash

set_hostname() {
    hostname=$(hostname_prompt)

    # Validate hostname for legal chars (and no spaces)
    while ! validate_hostname "$hostname"; do
        printf "❌ Invalid hostname: %s. Please try again.\n" "$hostname" >&2
        hostname=$(hostname_prompt)
    done
    printf "✅ Selected hostname: %s\n" "$hostname"
    
    if [ DRY_RUN -eq 0 ]; then
        echo "hostname: $hostname" > testhostname
    else
        echo "$hostname" > /etc/hostname
    fi
    
}

hostname_prompt() {
    # print messages to stderr so they don't get captured
    printf "Please select a hostname:\n" >&2
    local input
    input=$(gum input --placeholder "yourhostname")
    printf "Selected hostname: %s\n" "$input" >&2
    echo "$input"   # only the hostname is echoed to stdout
}

validate_hostname() {
    local teststring=$1
    # RFC 1123: labels up to 63 chars, letters/numbers/hyphen, no leading/trailing hyphen
    if [[ $teststring =~ ^(([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)(\.|$))+ ]]; then
        return 0
    else
        return 1
    fi
}