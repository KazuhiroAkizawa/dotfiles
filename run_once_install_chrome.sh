#!/usr/bin/env zsh

set -euxo pipefail

# https://qiita.com/7mpy/items/1bb144aea9f536d8955c

_install_chrome() {
    wget -qO- https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --yes --dearmor -o /etc/apt/trusted.gpg.d/google-chrome.gpg
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
    sudo apt-get update -y
    sudo apt-get install -y google-chrome-stable
}

if !(type google-chrome >/dev/null 2>&1); then
    _install_chrome
fi
