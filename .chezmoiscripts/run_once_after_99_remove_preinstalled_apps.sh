#!/usr/bin/env zsh

set -euxo pipefail

# http://slapper.sblo.jp/article/189636531.html

type libreoffice >/dev/null 2>&1 && sudo apt-get remove --purge "libreoffice*"
type thunderbird >/dev/null 2>&1 && sudo apt-get remove --purge "thunderbird*"
sudo apt-get clean
sudo apt-get autoremove
