#!/usr/bin/env bash

set -e

pkgs=(
    audacity
    bash-completion
    bc
    brightnessctl
    btop
    dbus-glib
    dunst
    engrampa
    fd
    ffmpeg
    firefox
    foot
    fzf
    gammastep
    gnome-disk-utility
    gnome-keyring
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
    openresolv
    p7zip
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
    arc-icon-theme
    arc-solid-gtk-theme
    mp3val
    nwg-displays
)

# pkg installation
    sudo sed -i 's/#Color/Color/' /etc/pacman.conf
    sudo pacman --needed --noconfirm -Syu "${pkgs[@]}"

    git clone https://aur.archlinux.org/yay-git.git
        (cd yay-git && makepkg --noconfirm -si)
    yay --needed --noconfirm -Syu "${pkgs_aur[@]}"

# dotfiles
    cp -r home_dir/. ~
    chmod +x ~/bin/*

# config (auto)
    gsettings set org.gnome.desktop.interface gtk-theme  'Arc-Dark-solid'
    gsettings set org.gnome.desktop.interface icon-theme 'Arc'

    printf 'kernel.unprivileged_userns_clone=1\n' | sudo tee /etc/sysctl.d/00-local-userns.conf

    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim +PlugInstall +q +q

# config (manual)
    sudo nvim /etc/xdg/user-dirs.defaults
    xdg-user-dirs-update
