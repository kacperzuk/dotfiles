#!/bin/sh

function install {
    if command -v pacman; then
        sudo pacman -S $@ --needed
    elif command -v yum; then
        sudo yum install $@
    else
        sudo apt-get install $@
    fi
}

OLD=~/dotfiles_old

if [[ -n $(dirname $0) ]]; then 
    cd $(dirname $0)
fi

cd dots

for file in $(find . -type f | sed "s|^\./||"); do
    if [ -e ~/.$file -o -L ~/.$file ]; then
        echo "Moving old $file to $OLD"
        mkdir -p $(dirname $OLD/$file)
        mv ~/.$file $OLD/$file
    fi
    echo "Creating symlink for $file"
    mkdir -p $(dirname ~/.$file)
    ln -s $(pwd)/$file ~/.$file
done

install fish tmux xterm
