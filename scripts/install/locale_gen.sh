#!/usr/bin/env bash

locale_gen() {
    select_locales
}

select_locales() {
    local selected_locales
    local chosen_lang
    local start_line=7

    # Read the list of locales
    while [ -z "$selected_locales" ]; do
        selected_locales=$(tail -n +$start_line /etc/locale.gen \
            | grep -vE '^\s*$' \
            | sed 's/^#\s*//' \
            | gum filter --placeholder "Select locales (TAB to multi-select, ENTER to confirm)" \
                         --height 15 --no-limit)
    done

    # Loop over each selected locale and uncomment in /etc/locale.gen
    while IFS= read -r locale; do
        # Escape special characters for sed
        sed -i "/^#.*$(printf '%s\n' "$locale" | sed 's/[[\.*^$()+?{|\\]/\\&/g')/s/^#\s*//" /etc/locale.gen
    done <<< "$selected_locales"

    if [ DRY_RUN -eq 0 ]; then
        echo "locale-gen"
    else
        locale-gen
    fi


    # Set the LANG variable
    while [ -z "$chosen_lang" ]; do
        chosen_lang=$(printf '%s\n' "$selected_locales" \
            | gum filter --placeholder "Select default locale to use for LANG variable" \
                         --height 10 \
                         --limit 1)
    done

    chosen_lang=$(echo "$chosen_lang" | awk '{print $1}')
    
    if [ DRY_RUN -eq 0 ]; then
        echo "LANG=$chosen_lang" ## e.g. en_US.UTF-8
    else
        echo "LANG=$chosen_lang" > /etc/locale.conf
    fi
}
