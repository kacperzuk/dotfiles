#!/bin/bash

OLD=$HOME/dotfiles_old

set -e

pushd dots >/dev/null

for file in $(find . -type f | sed "s|^\./||"); do
    if [ -e "$HOME/.$file" -o -L "$HOME/.$file" ]; then
        echo "Moving old $file to $OLD"
        mkdir -p "$(dirname $OLD/$file)"
        mv "$HOME/.$file" "$OLD/$file"
    fi
    echo "Creating symlink for '$file'"
    mkdir -p "$(dirname $HOME/.$file)"
    ln -s "$(pwd)/$file" "$HOME/.$file"
done

chmod go-rwx ~/.gnupg

popd >/dev/null

ln -s bin ~/

if [[ ! -e "$HOME/.config/fish/nvm-fish-wrapper" ]]; then
    git clone git://github.com/passcod/nvm-fish-wrapper.git "$HOME/.config/fish/nvm-fish-wrapper"
fi
if [[ ! -e "$HOME/.local/share/fonts/Literation Mono Powerline.ttf" ]]; then
    mkdir -p "$HOME/.local/share/fonts/"
    curl -L https://github.com/powerline/fonts/raw/master/LiberationMono/Literation%20Mono%20Powerline.ttf -o "$HOME/.local/share/fonts/Literation Mono Powerline.ttf"
    fc-cache -f "$HOME/.local/share/fonts/" &>/dev/null || true
fi
