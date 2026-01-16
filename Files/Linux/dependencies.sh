#!/bin/sh

dnf_install() {
    local dpackages=("${@}")
    for package in "${dpackages[@]}"; do
        if ! sudo dnf install $package -y; then
            echo "Failed to install $package, exiting..."
            exit 1
        fi
    done
}

flatpak_install() {
    local fpackages=("${@}")
    for package in "${fpackages[@]}"; do
        if ! flatpak install https://dl.flathub.org/repo/appstream/$package.flatpakref -y; then
            echo "Failed to install $package, exiting..."
            exit 1
        fi
    done
}

dnf_general=('fzf' 'gvfs' 'gvfs-mtp' 'htop' 'kitty' 'light' 'python3-pip' 'ranger' 'unzip' 'zsh')
dnf_install "${dnf_general[@]}"
