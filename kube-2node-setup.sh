#!/usr/bin/env bash
###########################
# Written by: Ron Negrov
# Date: 3.21.2025
# Purpose: In installtion script to use the vagrant kube generator.
# Version: 0.0.14
###########################
source /etc/os-release

main () {
    
    apt update
    distro_check_and_install git curl gnupg lsb-release

    curl -fsSL https://releases.hashicorp.com/vagrant/2.4.1/vagrant_2.4.1-1_amd64.deb -o vagrant.deb
    sudo dpkg -i vagrant.deb
    rm vagrant.deb

    git clone https://github.com/ronthesoul/vagrant-lib.git
    cd vagrant-lib/kube-2node
    vagrant up
}

install_missing_packages() {
    local package_manager=$1
    shift
    local package_list=("$@")

    for package in "${package_list[@]}"; do
        if ! command -v "$package" &>/dev/null && ! dpkg -l 2>/dev/null | grep -q "$package"; then
            echo "Installing missing package: $package"
            eval "$package_manager install -y $package"
        fi
    done
    echo "Finished installing packages"
}

distro_check_and_install() {
    source /etc/os-release

    case "$ID" in
        debian|ubuntu|kali)
            install_missing_packages "sudo apt" "$@"
            ;;
        centos|rhel|fedora)
            install_missing_packages "sudo yum" "$@"
            ;;
        arch)
            install_missing_packages "sudo pacman -S --noconfirm" "$@"
            ;;
        *)
            echo "Unsupported OS: $ID"
            exit 1
            ;;
    esac
}

main