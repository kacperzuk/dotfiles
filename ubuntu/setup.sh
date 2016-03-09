#!/bin/bash

set -e

sudo apt-add-repository multiverse
sudo apt-add-repository universe
sudo apt update

sudo apt install -y \
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
