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
    nethack-console \
    tmux \
    xterm

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60

sudo chsh -s /usr/bin/fish $USER

xrdb ~/.Xresources || true

nvim +PlugInstall +qall

tmux new nethack
bash -c "xterm fish &"
killall gnome-terminal-server
