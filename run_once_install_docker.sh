#!/usr/bin/env zsh

set -euxo pipefail

# https://docs.docker.com/engine/install/ubuntu/
# https://docs.docker.com/engine/install/linux-postinstall/

_install_docker() {
    # Add Docker's official GPG key:
    sudo apt-get update -y
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
        sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
    sudo apt-get update -y

    # Install tools
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # DNS configuration
    sudo apt-get install -y jq
    if [[ ! -e /etc/docker/daemon.json ]]; then
        echo '{"dns": ["8.8.8.8", "8.8.4.4"], "dns-search": ["."]}' | jq --indent 2 |
            sudo tee /etc/docker/daemon.json >/dev/null
    fi

    # Add user to docker group
    # Rebooting is needed to evaluate group membership
    [[ -z $(grep 'docker' /etc/group) ]] && sudo groupadd docker
    sudo usermod -aG docker $(whoami)
    newgrp docker
    docker run hello-world >/dev/null
    echo "You must reboot the machine to run docker without sudo."
}

if !(type docker >/dev/null 2>&1); then
    _install_docker
fi
