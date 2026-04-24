#!/usr/bin/env bash

set -euo pipefail

ok() { echo "  [OK] $*"; }

if [[ $# -ne 3 ]]; then
  echo "Usage: generate.sh <username> <realname> <password>"
  echo "Example: generate.sh melquisedec \"Melquisedec Felipe\" mypassword"
  exit 1
fi

USERNAME="$1"
REALNAME="$2"
PASSWORD="$3"

command -v mkpasswd &> /dev/null || sudo apt install -y whois

HASHED=$(echo "$PASSWORD" | mkpasswd -m sha-512 --stdin)

DIR="$(cd "$(dirname "$0")" && pwd)"

sed -e "s|realname: ''|realname: '$REALNAME'|" \
    -e "s|username: ''|username: '$USERNAME'|" \
    -e "s|password: ''|password: '$HASHED'|" \
    "$DIR/autoinstall.template.yaml" > "$DIR/autoinstall.yaml"

ok "autoinstall.yaml generated"
echo "  → serving on http://0.0.0.0:8000 for 60 seconds..."

python3 -m http.server 8000 --directory "$DIR" &
SERVER_PID=$!

trap "kill $SERVER_PID 2>/dev/null" EXIT

sleep 60
