#!/bin/sh

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

popd >/dev/null

if [[ ! -e "$HOME/.config/fish/nvm-fish-wrapper" ]]; then
    git clone git://github.com/passcod/nvm-fish-wrapper.git "$HOME/.config/fish/nvm-fish-wrapper"
fi
if [[ ! -e "$HOME/.local/share/fonts/Literation Mono Powerline.ttf" ]]; then
    curl -fLo "$HOME/.local/share/fonts/Literation Mono Powerline.ttf" https://github.com/powerline/fonts/raw/master/LiberationMono/Literation%20Mono%20Powerline.ttf
    fc-cache -f "$HOME/.local/share/fonts/"
fi
