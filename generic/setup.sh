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
