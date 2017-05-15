#!/bin/bash

set -e

if [[ -n "$(dirname $0)" ]]; then
    cd "$(dirname $0)"
fi

sudo pacman -Syu --noconfirm --needed \
    fish \
    git \
    neovim \
    nodejs npm \
    sshuttle \
    tmux \
    xterm

sudo chsh -s /usr/bin/fish $USER

if [[ "$1" == "--full" ]]; then
    sudo pacman -S archlinux-keyring --needed
    sudo pacman -S reflector rsync --noconfirm --needed
    sudo reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist

    sudo pacman -S --noconfirm --needed \
        archlinux-wallpaper \
        base-devel \
        chromium \
        colordiff \
        cryptsetup \
        cups \
        cups-pdf \
        dmidecode \
        dosfstools \
        feh \
        firefox \
        geary \
        gimp \
        gnome-keyring \
        gparted \
        gsimplecal \
        haveged \
        hplip \
        i3-wm \
        i3status \
        intel-ucode \
        iotop \
        iw \
        l3afpad \
        libreoffice-fresh libreoffice-fresh-pl \
        logrotate \
        ncdu \
        nethack \
        networkmanager nm-connection-editor network-manager-applet \
        nmap \
        ntfs-3g \
        openbsd-netcat \
        openssh \
        owncloud-client \
        pass \
        pulseaudio-bluetooth \
        pv \
        redshift \
        rofi \
        simple-scan \
        smplayer \
        virtualbox virtualbox-host-dkms virtualbox-guest-iso \
        whois \
        wireshark-cli wireshark-gtk tcpdump \
        xautolock \
        xclip \
        xorg xorg-drivers xorg-apps xorg-fonts xorg-xinit

    gpg --keyserver hkp://pgp.mit.edu --recv-keys 'BA1E E421 BBB4 5263 180E  1FC7 2E1A C68E D408 14E0' # tor-browser-en
    gpg --keyserver hkp://pgp.mit.edu --recv-keys '487E ACC0 8557 AD08 2088  DABA 1EB2 638F F56C 0C53' # cower

    for package in \
        cower \
        dropbox dropbox-cli \
        tor-browser-en \
        xsecurelock-git
    do
        if ! pacman -Q $package &>/dev/null; then
            DIR=`mktemp -d`
            pushd "$DIR" >/dev/null
            curl -LO https://aur.archlinux.org/cgit/aur.git/snapshot/${package}.tar.gz
            tar xf ${package}.tar.gz
            cd $package
            makepkg -si --noconfirm
            popd
            rm -rf "$DIR"
        fi
    done

    nvim +PlugInstall +qall

    if [[ $(sudo dmidecode -s system-product-name) = "VirtualBox" ]]; then
        sudo pacman -S --noconfirm virtualbox-guest-{utils,modules-arch}
        sudo modprobe vboxvideo vboxguest vboxsf
    fi
    echo Run \"startx\" to begin.
fi
