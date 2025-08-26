#!/usr/bin/env bash

source scripts/runtime_environment.sh

main() {
    echo "=== Arch Linux Environment Detection ==="
    echo

    detect_environment
    env_status=$?
    
    # Detect the environment
    if [ $env_status -eq 1 ]; then
        echo
        echo "=== INSTALLER USB ENVIRONMENT DETECTED ==="
    elif [ $env_status -eq 0 ]; then
        echo
        echo "=== EXISTING INSTALLATION DETECTED ==="
    else
        echo
        echo "=== UNSUPPORTED INSTALLATION DETECTED ==="
    fi
}

main "$@"