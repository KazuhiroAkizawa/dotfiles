#!/usr/bin/env zsh

set -euxo pipefail

# https://qiita.com/yoshiyasu1111/items/e21a77ed68b52cb5f7c8
# https://zenn.dev/karaage0703/books/80b6999d429abc8051bb/viewer/5b814b
# https://raw.githubusercontent.com/karaage0703/ubuntu-setup/master/install-vscode.sh

_install_vscode() {
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt-get update -y
    sudo apt-get install -y code
}

if !(type code >/dev/null 2>&1); then
    _install_vscode
fi
