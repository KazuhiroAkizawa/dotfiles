#!/usr/bin/env zsh

set -euxo pipefail

if ! type starship >/dev/null 2>&1; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi
