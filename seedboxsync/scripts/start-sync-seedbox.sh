#!/usr/bin/env bash

set -e

USERNAME="user"
GROUPNAME="$USERNAME"

# Create group if it doesn't exist
if ! getent group $GROUPNAME >/dev/null 2>&1; then
    addgroup -g $GROUP_ID $GROUPNAME
fi

# Create user if it doesn't exist
if ! id -u $USERNAME >/dev/null 2>&1; then
    adduser -D -u $USER_ID -G $GROUPNAME $USERNAME
fi

su-exec "$USERNAME" supercronic "/etc/crontabs/sync-seedbox"
