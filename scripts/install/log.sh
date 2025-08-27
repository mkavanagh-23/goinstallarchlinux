#!/usr/bin/env bash

gum_log() {
    # Must have at least 2 arguments: loglevel + message
    if [ $# -lt 2 ]; then
        echo "Usage: gum_log [filepath] <loglevel> <logmessage> [key value]..."
        return 1
    fi

    local loglevel="$1"
    shift 1
    local logmessage="$1"
    shift 1

    # Validate loglevel
    case "$loglevel" in
        debug|info|warn|error|fatal)
            ;;
        *)
            echo "Invalid loglevel: $loglevel. Valid values: debug, info, warn, error, fatal"
            return 1
            ;;
    esac

    # Validate key-value pairs
    if (( $# % 2 != 0 )); then
        echo "Invalid arguments: Key-value args must come in pairs."
        return 1
    fi

    # Build gum command arguments
    local gum_args=(--structured -t DateTime --level "$loglevel" "$logmessage")
    while (( $# > 0 )); do
        local key="$1"
        local value="$2"
        gum_args+=("$key" "$value")
        shift 2
    done

    # Return array via global variable (safe for spaces)
    _GUM_LOG_ARGS=("${gum_args[@]}")
}

log_to_console() {
    gum_log "$@" || return 1
    gum log "${_GUM_LOG_ARGS[@]}"
}

log_to_file() {
    log_file="/var/log/goinstallarchlinux/bash.log"
    shift
    gum_log "$@" || return 1 
    {
        gum log "${_GUM_LOG_ARGS[@]}" 
    } >> "$log_file" 2>&1
}