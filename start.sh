#!/usr/bin/env bash

# This script bootstraps, builds and runs the overall program
# Serves as the main entrypoint into the overall application

set -euo pipefail
log_dir="/var/log/goinstallarchlinux"
log_file="bash.log"

for file in scripts/install/*.sh; do
    [ -f "$file" ] && source "$file"
done

main() {
    echo "=== Arch Linux Environment Detection ==="
    env_status=$(detect_environment)
    case "$env_status" in
      "installer")
        echo "=== INSTALLER USB ENVIRONMENT DETECTED ==="
        t2_status=$(detect_t2)
        case "$t2_status" in
          "t2")
            echo "=== T2 LINUX DETECTED ==="
            install "t2"
          ;;
          *)
            echo "=== VANILLA ARCH DETECTED ==="
            install "vanilla"
          ;;
        esac
      ;;
      "existing")
        echo "=== EXISTING INSTALLATION DETECTED ==="
        t2_status=$(detect_t2)
        case "$t2_status" in
          "t2")
            echo "=== T2 LINUX DETECTED ==="
            postinstall_t2
          ;;
          *)
            echo "=== VANILLA ARCH DETECTED ==="
            postinstall_vanila
          ;;
        esac
      ;;
      *)
        echo "=== UNSUPPORTED INSTALLATION DETECTED ==="
        echo "Please exit and re-run the script from a bare metal Arch Linux environment."
        install "vanilla"
      ;;
    esac
}

main "$@"