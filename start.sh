#!/usr/bin/env bash

#
# Run with `sudo ./start.sh`
# or `sudo ./start.sh update` to also update all containers.
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
if [[ $1 = "update" ]]; then
    docker_cmd_down=("${docker_cmd[@]}" "down")
    eval "${docker_cmd_down[@]}"
    docker_cmd_down=("${docker_cmd[@]}" "pull")
    eval "${docker_cmd_update[@]}"
fi

docker_cmd+=("up -d")
eval "${docker_cmd[@]}"

