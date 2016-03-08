#!/bin/bash

set -e

sudo pacman -Syu --noconfirm --needed \
    fish \
    git \
    neovim \
    httpie \
    meld \
    nodejs npm \
    sshuttle \
    tmux \
    xterm

sudo chsh -s /usr/bin/fish $USER

if [[ "$1" == "--full" ]]; then
    sudo pacman -S --noconfirm --needed \
        abs \
        ansible \
        apvlv \
        archlinux-wallpaper \
        base-devel \
        chromium \
        colordiff \
        cryptsetup \
        cups \
        cups-pdf \
        dosfstools \
        firefox \
        gimp \
        gnome-keyring \
        gparted \
        gsimplecal \
        haveged \
        hplip \
        i3-wm \
        i3lock \
        i3status \
        inkscape \
        intel-ucode \
        iotop \
        iw \
        jq \
        l3afpad \
        libreoffice-fresh libreoffice-fresh-pl \
        lightdm \
        logrotate \
        mariadb \
        mongodb mongodb-tools \
        ncdu \
        nethack \
        networkmanager nm-connection-editor networkmanager-openvpn network-manager-applet \
        nmap \
        ntfs-3g \
        octave \
        openbsd-netcat \
        openssh \
        owncloud-client \
        pam_mount \
        pass \
        php php-apache php-composer php-gd php-mcrypt php-memcached php-mongodb php-pgsql php-sqlite \
        postfix \
        postgresql \
        pulseaudio-bluetooth \
        pv \
        python2-scikit-learn \
        redshift \
        reflector \
        rofi \
        simple-scan \
        smplayer \
        tor torsocks \
        transmission-gtk \
        virtualbox virtualbox-host-dkms virtualbox-guest-iso \
        vlc \
        whois \
        wireshark-cli wireshark-gtk tcpdump \
        xautolock \
        xclip \
        xorg xorg-drivers xorg-apps xorg-fonts

    sudo reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist
    sudo systemctl enable lightdm
    sed -i "/greeter-session=/c\\greeter-session=lightdm-webkit2-greeter" /etc/lightdm/lightdm.conf


    if ! hash aura &>/dev/null; then
        DIR=`mktemp -d`
        pushd "$DIR" >/dev/null
        wget https://aur.archlinux.org/cgit/aur.git/snapshot/aura-bin.tar.gz
        tar xf aura-bin.tar.gz
        cd aura-bin
        makepkg -si --noconfirm
        popd
        rm -rf "$DIR"
    fi

    sudo aura -A --needed \
        dropbox dropbox-cli \
        napi-bash \
        openxenmanager-git \
        tor-browser-en \
        lightdm-webkit2-greeter \
        lightdm-webkit-theme-material-git \
        octave-communications octave-image octave-signal octave-statistics

    sed -i "/webkit-theme=/c\\webkit-theme=material" /etc/lightdm/lightdm-webkit2-greeter.conf

    sudo cp i3lock@.service /etc/systemd/system/i3lock@.service
    sudo systemctl enable i3lock@$USER

    echo Run \"sudo systemctl start lightdm\" to begin.
fi
