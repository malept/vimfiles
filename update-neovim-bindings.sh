#!/usr/bin/env bash

set -e -o -u pipefail

# shellcheck source=/dev/null
source ~/.local/share/virtualenv/neovim/bin/activate
pip install -U pynvim
