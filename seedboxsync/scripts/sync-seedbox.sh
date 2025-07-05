#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

config="$(cat "$SCRIPT_DIR/config/sync-config.json")"

url="$(echo "$config" | jq -r '.url')"
username="$(echo "$config" | jq -r '.username')"
password="$(echo "$config" | jq -r '.password')"

echo "$config" | jq -c '.dirs[]' | while read -r item; do
    src=$(echo "$item" | jq -r '.source')
    tgt=$(echo "$item" | jq -r '.target')

    echo "Downloading from $url, copying $src to $tgt"

    lftp "$url" \
        -u "$username,$password" \
        -e "set sftp:auto-confirm yes; mirror -vvv --parallel --delete --continue --delete-first \"$src\" \"$tgt\"" \
        < /dev/null 2>&1
done

