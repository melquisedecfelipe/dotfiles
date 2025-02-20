#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"
cd ..

command -v whois &> /dev/null || sudo apt install -y whois
command -v python3 &> /dev/null || sudo apt install -y python3

if [[ ! -f .env ]]; then
    exit 1
fi

source .env

if [[ -z "$UBUNTU_USERNAME" || -z "$UBUNTU_REALNAME" || -z "$UBUNTU_PASSWORD" ]]; then
    exit 1
fi

PASSWORD=$(echo "$UBUNTU_PASSWORD" | mkpasswd -m sha-512 --stdin)

sed -e "s|realname: ''|realname: '$UBUNTU_REALNAME'|" \
    -e "s|username: ''|username: '$UBUNTU_USERNAME'|" \
    -e "s|password: ''|password: '$PASSWORD'|" \
    "linux/autoinstall.template.yaml" > "linux/autoinstall.yaml"

cd linux

python3 -m http.server 8000 &
SERVER_PID=$!

sleep 60

kill $SERVER_PID
