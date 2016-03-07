sudo pacman -Syu --noconfirm \
    fish \
    git \
    gvim \
    httpie \
    meld \
    nodejs npm \
    sshuttle \
    tmux \
    xterm

sudo -i -u $USER chsh -s /usr/bin/fish

if [[ "$1" == "--full" ]]; then
    sudo pacman -S --noconfirm \
        abs \
        ansible \
        archlinux-wallpaper \
        base-devel \
        chromium \
        colordiff \
        cryptsetup \
        cups \
        cups-pdf \
        dosfstools \
        evince \
        firefox \
        gimp \
        gparted \
        haveged \
        hplip \
        i3-wm \
        i3status \
        inkscape \
        intel-ucode \
        iotop \
        iw \
        jq \
        l3afpad \
        libreoffice-fresh libreoffice-fresh-pl \
        lightdm \
        light-lock \
        logrotate \
        mariadb \
        mongodb mongodb-tools \
        ncdu \
        nethack \
        networkmanager nm-connection-editor networkmanager-openvpn network-manager-applet \
        nmap \
        ntfs-3g \
        octave octave-communications octave-image octave-signal octave-statistics \
        openbsd-netcat \
        openssh \
        owncloud-client \
        pam_mount \
        pass \
        php php-apache php-composer php-gd php-mcrypt php-memcached php-mongo php-pear php-pgsql php-sqlite \
        postfix \
        postgresql \
        pv \
        python2-scikit-learn \
        pulseaudio-bluetooth \
        redshift \
        reflector \
        rofi \
        simple-scan \
        smplayer \
        steam \
        tor tor-browser-en torsocks \
        transmission-gtk \
        virtualbox virtualbox-host-dkms virtualbox-guest-iso \
        vlc \
        whois \
        wireshark-cli wireshark-gtk tcpdump \
        xclip \
        xorg xorg-drivers xorg-apps xorg-fonts

    sudo reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist
    sudo systemctl enable lightdm
    sed -i "/greeter-session=/c\greeter-session=lightdm-webkit2-greeter" /etc/lightdm/lightdm.conf


    DIR=`mktemp -d`
    pushd "$DIR" >/dev/null
    wget https://aur.archlinux.org/cgit/aur.git/snapshot/aura-bin.tar.gz
    tar xf aura-bin.tar.gz
    cd aura-bin
    makepkg -si --noconfirm
    popd
    rm -rf "$DIR"

    sudo aura -A \
        dropbox dropbox-cli \
        napi-bash \
        openxenmanager-git \
        lightdm-webkit2-greeter
fi
