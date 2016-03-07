#!/bin/bash

if ! hash git &>/dev/null; then

    hash pacman &>/dev/null && sudo pacman -Sy git --noconfirm

    hash apt-get &>/dev/null \
        && sudo apt-get update \
        && sudo apt-get install git -y
fi

cd $HOME
[[ ! -e dotfiles ]] && \
    git clone https://bitbucket.org/Kazuldur/dotfiles.git

cd dotfiles
git pull
if [[ -n "$FULL_SETUP" ]]; then
    ./setup.sh --full
else
    ./setup.sh
fi
