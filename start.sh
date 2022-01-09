#!/usr/bin/env bash

#
# Start all containers: `sudo ./start.sh`
# Update all containers: `sudo ./start.sh update`
# Restart all containers: `sudo ./start.sh restart`
# Stop all containers: `sudo ./start.sh stop`
#

# Find all compose files (gluetun has to be handled manually)
docker_cmd=("docker-compose")
for config in docker/*.yml; do
    if [[ $config != *"gluetun"* ]]; then
        docker_cmd+=("-f $config")
    fi
done

# Optionally down all and update
if [[ $1 == "update" || $1 == "restart"  || $1 == "stop" ]]; then
    docker_cmd_down=("${docker_cmd[@]}" "down")
    eval "${docker_cmd_down[@]}"

    if [[ $1 == "update" ]]; then
        docker_cmd_update=("${docker_cmd[@]}" "pull")
        eval "${docker_cmd_update[@]}"
    fi
fi

if [[ $1 != "stop" ]]; then
    docker_cmd+=("up -d")
    eval "${docker_cmd[@]}"
fi
