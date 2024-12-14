#!/usr/bin/env bash

set -euxo pipefail

# Install zsh
if ! type zsh >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y zsh
fi
