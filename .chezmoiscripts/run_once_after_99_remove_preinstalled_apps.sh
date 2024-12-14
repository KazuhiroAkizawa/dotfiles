#!/usr/bin/env zsh

set -euxo pipefail

# http://slapper.sblo.jp/article/189636531.html

type libreoffice >/dev/null 2>&1 && sudo apt-get remove --purge "libreoffice*" -y
type thunderbird >/dev/null 2>&1 && sudo apt-get remove --purge "thunderbird*" -y
sudo apt-get clean -y
sudo apt-get autoremove -y
