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

    [ ! -x "$(command -v docker-compose)" ] && {
        echo "Installing docker-compose"
        apt-get install -y libffi-dev libssl-dev \
            python3 python3-pip

        pip3 install docker-compose
    }

    systemctl enable docker --now
}

function setup_mdns() {
    [ ! -x "$(command -v mdns-publish-cname)" ] && {
        echo "Installing mdns-publisher"
        pip3 install mdns-publisher
    }

    [ ! -f "/etc/systemd/system/mdns-publisher.service" ] &&
        ln -s $PWD/services/mdns-publisher/mdns-publisher.service /etc/systemd/system/mdns-publisher.service

    [ ! -f "/usr/local/bin/mdns-publisher.sh" ] &&
        ln -s $PWD/services/mdns-publisher/mdns-publisher.sh /usr/local/bin/mdns-publisher.sh

    systemctl daemon-reload
    systemctl enable --now mdns-publisher.service
}

setup_mdns
install_docker
