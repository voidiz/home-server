#!/usr/bin/env bash

#
# Start all containers: `sudo ./start.sh`
# Update all containers: `sudo ./start.sh update`
# Restart all containers: `sudo ./start.sh restart`
#

source env.sh

# Print variables
echo "USER_NAME: $(who am i | awk '{print $1}')"
echo "CONFIG_PATH: $CONFIG_PATH"
echo "STORAGE_PATH: $STORAGE_PATH"
echo "SMB_USER_NAME: $SMB_USER_NAME"
echo "SMB_PASSWORD: <hidden>"

# Start all containers
docker_cmd=("docker-compose")
for config in docker/*.yml; do
    docker_cmd+=("-f $config")
done

# Optionally down all and update
if [[ $1 == "update" || $1 == "restart" ]]; then
    docker_cmd_down=("${docker_cmd[@]}" "down")
    eval "${docker_cmd_down[@]}"

    if [[ $1 == "update" ]]; then
        docker_cmd_down=("${docker_cmd[@]}" "pull")
        eval "${docker_cmd_update[@]}"
    fi
fi

docker_cmd+=("up -d")
eval "${docker_cmd[@]}"

