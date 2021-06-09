#!/bin/bash

set -e

function install_aur_package {
    package=$1
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
}

if [[ -n "$(dirname $0)" ]]; then
    cd "$(dirname $0)"
fi

sudo pacman -Syu --noconfirm --needed \
    fish \
    git \
    neovim \
    tmux \
    colordiff \
    ncdu \
    archlinux-keyring \
    alacritty

sudo chsh -s /usr/bin/fish $USER
nvim +PlugInstall +qall

if [[ "$1" == "--full" ]]; then
    sudo pacman -S reflector rsync --noconfirm --needed
    sudo reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist

    sudo pacman -S --noconfirm --needed \
        archlinux-wallpaper \
        base-devel \
        cryptsetup \
        cups \
        evince eog gedit \
        jq \
        wireguard-{dkms,tools} \
        cups-pdf \
        dmidecode \
        dosfstools \
        firefox-developer-edition \
        geary \
        gimp \
        gnome-keyring \
        gparted \
        gsimplecal \
        haveged \
        sway swaylock swayidle \
        i3status \
        py3status \
        intel-ucode \
        iotop \
        iw \
        libreoffice-fresh libreoffice-fresh-pl \
        logrotate \
        networkmanager nm-connection-editor network-manager-applet \
        nmap \
        ntfs-3g \
        openbsd-netcat \
        openssh \
        nextcloud-client \
        pass \
        pulseaudio-bluetooth \
        pv \
        rofi \
        simple-scan \
        virtualbox virtualbox-host-dkms virtualbox-guest-iso \
        whois \
        discord \
        signal-desktop \
        light \
        ponymix \
        kanshi \
        openvpn \
        mako \
        wireshark-cli wireshark-gtk tcpdump

    gpg --keyserver hkp://pgp.mit.edu --recv-keys 'BA1E E421 BBB4 5263 180E  1FC7 2E1A C68E D408 14E0' # tor-browser-en

    for package in \
        rua \
        tor-browser-en \
        evdi \
        displaylink \
        clipman \
        ledger-udev
    do
        install_aur_package $package
    done

    if [[ $(sudo dmidecode -s system-product-name) = "VirtualBox" ]]; then
        sudo pacman -S --noconfirm virtualbox-guest-{utils,modules-arch} --needed
        sudo modprobe vboxvideo vboxguest vboxsf
    fi
    echo Run \"sway\" to begin.
fi
