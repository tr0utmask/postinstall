#!/bin/sh

# Arch Linux post-installation script

## Go home
cd || echo "Your home directory is not set. Make sure that you're running this script as a regular user and that you have a home directory." && exit

## Update system
sudo pacman -Syu

## Install git
sudo pacman -S git

## Install yay
git clone https://aur.archlinux.org/yay
cd yay || echo "Couldn't enter yay's directory. Did git clone work correctly?" && exit
makepkg -si
cd || echo "Your home directory is not set. Make sure that you're running this script as a regular user and that you have a home directory." && exit

## When yay is installed, install the necessary packages
yay -S adobe-source-han-sans-otc-fonts dunst feh firefox gnome-themes-extra gtk-engines gvim htop libnotify lxappearance mpv mupdf pulseaudio pulseaudio-alsa pulsemixer rxvt-unicode scrot thunar ttf-go-sans-git ttf-ms-fonts tumbler unrar unzip xorg-fonts-misc xorg-server xorg-xinit xorg-xrandr xorg-xset xorg-xsetroot yt-dlp

printf "\nPlease install the appropriate graphics drivers yourself.\n\n"

## Clone dotfiles repo
git clone https://github.com/tr0utmask/dotfiles

## Copy files over
cp -v dotfiles/.bashrc ~
cp -v dotfiles/.profile ~
cp -v dotfiles/.xinitrc ~
cp -rv dotfiles/.vim ~
mkdir -p ~/.local/src
cp -rv dotfiles/.local/src/* ~/.local/src
mkdir -p ~/.local/bin
cp -rv dotfiles/.local/bin/* ~/.local/bin
mkdir -p ~/.config
cp -rv dotfiles/.config/* ~/.config

## Build suckless utilities
cd ~/.local/src/dwm || echo "dwm directory not found. Did it copy over correctly?" && exit
sudo make clean install
cd ~/.local/src/dmenu || echo "dmenu directory not found. Did it copy over correctly?" && exit
sudo make clean install
cd ~/.local/src/slock || echo "slock directory not found. Did it copy over correctly?" && exit
sed -i "s/\"user\"/\"$(whoami)\"/" config.h
sudo make clean install
