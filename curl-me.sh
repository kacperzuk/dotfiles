#!/bin/bash

if ! hash git &>/dev/null; then

    hash pacman &>/dev/null && sudo pacman -Sy git --noconfirm

    hash apt-get &>/dev/null \
        && sudo apt-get update \
        && sudo apt-get install git -y
fi

cd $HOME

# todo: check if exists and ask user
rm -rf dotfiles
git clone https://bitbucket.org/Kazuldur/dotfiles.git
cd dotfiles

# todo: ask if full
if [[ -n "$FULL_SETUP" ]]; then
    ./setup.sh --full
else
    ./setup.sh
fi
