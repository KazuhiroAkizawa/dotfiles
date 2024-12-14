#!/usr/bin/env zsh

set -euxo pipefail

# https://github.com/alacritty/alacritty/blob/master/INSTALL.md

_install_alacritty() {
    # Install Rust language and tools
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustup override set stable
    rustup update stable

    # Clone repo
    mkdir -p ~/.local/lib && cd ~/.local/lib
    git clone https://github.com/alacritty/alacritty.git
    cd alacritty

    # Install dependencies and build
    sudo apt-get install -y \
        cmake \
        g++ \
        pkg-config \
        libfreetype6-dev \
        libfontconfig1-dev \
        libxcb-xfixes0-dev \
        libxkbcommon-dev \
        python3
    cargo build --release

    # Post build
    # Terminfo
    infocmp alacritty >/dev/null 2>&1 || sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

    # Desktop Entry
    mkdir -p ~/.local/bin
    sudo cp target/release/alacritty ~/.local/bin
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install extra/linux/Alacritty.desktop
    sudo update-desktop-database

    # Manual page
    sudo apt-get update -y
    sudo apt-get install -y gzip scdoc
    sudo mkdir -p /usr/local/share/man/man1
    sudo mkdir -p /usr/local/share/man/man5
    scdoc <extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz >/dev/null
    scdoc <extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz >/dev/null
    scdoc <extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz >/dev/null
    scdoc <extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz >/dev/null

    # Completion
    mkdir -p ${ZDOTDIR:-~}/.zsh_functions
    cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty
}

if !(type alacritty >/dev/null 2>&1); then
    _install_alacritty
fi
