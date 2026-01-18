#!/usr/bin/env bash

set -e

pkgs=(
    7zip
    audacity
    base-devel
    bash-completion
    bc
    brightnessctl
    btop
    dbus-glib
    dunst
    engrampa
    fd
    ffmpeg
    foot
    fzf
    gammastep
    gnome-disk-utility
    gnome-keyring
    gnome-themes-extra
    gparted
    grim
    gvfs
    gvfs-mtp
    i3status
    keepassxc
    kid3-qt
    man-db
    mpv
    neovim
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    nsxiv
#   nvidia-open
    nwg-look
    openresolv
    pulsemixer
    qbittorrent
    ristretto
    rsync
    shellcheck
    slurp
    sway
    swaybg
    swaylock
    thunar
    thunar-archive-plugin
    thunar-volman
    wireguard-tools
    wl-clipboard
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    xdg-user-dirs
    xorg-xwayland
    yt-dlp
    zathura-cb
    zathura-pdf-mupdf
)

pkgs_aur=(
    anki-bin
    brave-bin
    jmtpfs
    mp3val
    nwg-displays
)

# pkg installation
    sudo sed -i 's/#Color/Color/' /etc/pacman.conf
    sudo pacman --needed --noconfirm -Syu "${pkgs[@]}"

    git clone https://aur.archlinux.org/paru.git
        (cd paru && makepkg --noconfirm -si)
    paru --needed --noconfirm -Syu "${pkgs_aur[@]}"

# dotfiles
    cp -r home_dir/. ~
    chmod +x ~/bin/*

# config (auto)
    printf 'kernel.unprivileged_userns_clone=1\n' | sudo tee /etc/sysctl.d/00-local-userns.conf

    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim +PlugInstall +q +q

# config (manual)
    sudo nvim /etc/xdg/user-dirs.defaults
    xdg-user-dirs-update
