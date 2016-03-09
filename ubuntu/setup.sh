#!/bin/bash

set -e

sudo apt-add-repository multiverse
sudo apt-add-repository universe
sudo apt-add-repository ppa:neovim-ppa/unstable
sudo apt update

sudo apt install -y \
    fish \
    git \
    httpie \
    neovim \
    tmux \
    xterm

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60

sudo chsh -s /usr/bin/fish $USER

echo "Open xterm to begin"
