#!/usr/bin/env zsh

set -euxo pipefail

_install_awscli_v2() {
    cd /tmp
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install

    rm awscliv2.zip
    rm -rf aws
}

if ! (type aws >/dev/null 2>&1) || [[ -n "$(aws --version | grep -E "^aws\-cli/1\..*$")" ]]; then
    sudo apt remove -y awscli
    sudo apt autoremove -y

    _install_awscli_v2
fi
