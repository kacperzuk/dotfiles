#!/bin/bash

set -e

sudo apt-get update
sudo apt-get install -y \
    fish \
    git \
    gvim \
    httpie \
    meld \
    nodejs npm \
    sshuttle \
    tmux \
    xterm

chsh -s /usr/bin/fish
