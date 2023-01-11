#!/usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

# https://github.com/dylanaraps/pure-bash-bible

sudo apt-get install -y shellcheck
shellcheck *.sh
