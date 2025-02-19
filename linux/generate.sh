#!/usr/bin/env bash

set -euo pipefail

sudo apt update && sudo apt install -y whois curl python3

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source .env

PASSWORD=$(echo "$UBUNTU_PASSWORD" | mkpasswd -m sha-512 --stdin)

sed -e "s|realname: ''|realname: '$UBUNTU_REALNAME'|" \
    -e "s|username: ''|username: '$UBUNTU_USERNAME'|" \
    -e "s|password: ''|password: '$PASSWORD'|" \
    "$DIR/autoinstall.template.yaml" > "$DIR/autoinstall.yaml"

cd "$DIR" && python3 -m http.server 8000
