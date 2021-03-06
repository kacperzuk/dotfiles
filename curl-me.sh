#!/bin/bash

clear

if [[ -e dotfiles ]]; then
    if [[ -z "$OVERWRITE_DOTFILES" ]]; then
        read -p "~/dotfiles already exists. Should it be removed and cloned again? [Y/n] " OVERWRITE_DOTFILES </dev/tty
    fi
else
    OVERWRITE_DOTFILES=y
fi

if [[ -z "$FULL_SETUP" ]]; then
    read -p "Full setup? [y/N] " FULL_SETUP </dev/tty
fi

if ! hash git &>/dev/null; then

    hash pacman &>/dev/null && sudo pacman -Sy git --noconfirm

    hash apt-get &>/dev/null \
        && sudo apt-get update \
        && sudo apt-get install git -y
fi

cd $HOME

if [[ "$OVERWRITE_DOTFILES" != "n" ]]; then
    rm -rf dotfiles
    git clone -q https://github.com/kacperzuk/dotfiles.git
fi

cd dotfiles

if [[ "$FULL_SETUP" == "y" ]]; then
    ./setup.sh --full
else
    ./setup.sh
fi
