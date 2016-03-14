#!/bin/bash

set -e

echo "deb http://debian.sur5r.net/i3 trusty universe" >> /etc/apt/sources.list

sudo apt-add-repository multiverse
sudo apt-add-repository universe
sudo apt-add-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y sur5r-keyring
sudo apt install -y i3 i3status

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

xrdb ~/.Xresources

tmux new -d nethack
xterm -e 'echo "Close this term after installation finishes" | nvim - +PlugInstall'
bash -c "bash -c 'xterm fish &'"
killall gnome-terminal-server
