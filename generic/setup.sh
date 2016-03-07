#!/bin/sh

OLD=$HOME/dotfiles_old

if [[ -n "$(dirname $0)" ]]; then
    cd "$(dirname $0)"
fi

cd dots

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
