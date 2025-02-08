#!/usr/bin/env bash

set -euo pipefail

if ! command -v mkpasswd &> /dev/null; then
    sudo apt update && sudo apt install -y whois curl
fi

if ! command -v python3 &> /dev/null; then
    sudo apt update && sudo apt install -y python3
fi

if [ ! -f .env ]; then
    exit 1
fi

source .env

UBUNTU_PASSWORD=$(echo "$UBUNTU_PASSWORD" | mkpasswd -m sha-512 --stdin)

sed -e "s/realname: ''/realname: '$UBUNTU_REALNAME'/" \
    -e "s/username: ''/username: '$UBUNTU_USERNAME'/" \
    -e "s/password: ''/password: '$UBUNTU_PASSWORD'/" \
    linux/autoinstall.template.yaml > linux/autoinstall.yaml

cd linux && python3 -m http.server 8000
