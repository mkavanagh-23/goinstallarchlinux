#!/usr/bin/env bash

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
            install_t2
          ;;
          *)
            echo "=== VANILLA ARCH DETECTED ==="
            install_vanila
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
        echo "Please exit and re-run the script from an Arch Linux machine."
      ;;
    esac
}

main "$@"