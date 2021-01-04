#!/usr/bin/env bash

#
# Run with `sudo ./setup.sh`
#

source env.sh

CONTAINERS=(
    linuxserver/syncthing
)

function install_docker() {
    [ ! -x "$(command -v docker)" ] && {
        echo "Installing docker"
        curl -fsSL https://get.docker.com -o get-docker.sh
        sh get-docker.sh
        rm get-docker.sh
        usermod -aG docker "$(who am i | awk '{print $1}')"
    }

    [ ! -x "$(command -v docker-compose)" ] && {
        echo "Installing docker-compose"
        apt-get install -y libffi-dev libssl-dev \
            python3 python3-pip

        pip3 install docker-compose
    }
}

install_docker
