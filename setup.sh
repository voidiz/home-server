#!/usr/bin/env bash

#
# Run with `sudo ./setup.sh`
#

function install_docker() {
    [ ! -x "$(command -v docker)" ] && {
        echo "Installing docker"
        curl -fsSL https://get.docker.com -o get-docker.sh
        sh get-docker.sh
        rm get-docker.sh
        usermod -aG docker "$(who am i | awk '{print $1}')"
    }

    systemctl enable docker --now
}

function setup_tailscale() {
    [ ! -x "$(command -v tailscale)" ] && {
        curl -fsSL https://tailscale.com/install.sh | sh
    }

    # Don't want to use pi-hole on the same machine as DNS server
    tailscale up --accept-dns=false
}

install_docker
setup_tailscale
