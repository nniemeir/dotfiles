#!/usr/bin/env bash
manual=$(man -k . | sort -u | awk '{print $1, $2}' | fzf --prompt="Manuals: " | awk '{print $1}')

if [[ -n "$manual" ]]; then
    man $manual
fi

exit 0


