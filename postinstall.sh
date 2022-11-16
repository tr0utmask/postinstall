#!/bin/sh

# Arch Linux post-installation script

## Go home
cd ~ || exit

## Update system
sudo pacman --noconfirm -Syu

## Install git
sudo pacman --noconfirm -S git

## Install yay
git clone https://aur.archlinux.org/yay
cd yay || exit
makepkg --noconfirm -si
cd ~ || exit

## When yay is installed, install the necessary packages
yay -S adobe-source-han-sans-otc-fonts dunst feh firefox gnome-themes-extra gtk-engines gvim htop libnotify lxappearance mpv mupdf pulseaudio pulseaudio-alsa pulsemixer rxvt-unicode scrot thunar ttf-go-sans-git ttf-ms-fonts tumbler unrar unzip xcape xorg-fonts-misc xorg-server xorg-xinit xorg-xrandr xorg-xset xorg-xsetroot yt-dlp

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
cd ~/.local/src/dwm || exit
sudo make clean install
cd ~/.local/src/dmenu || exit
sudo make clean install
cd ~/.local/src/slock || exit
sed -i "s/\"user\"/\"$(whoami)\"/" config.h
sudo make clean install

## Disable pc speaker
sudo rmmod pcspkr
echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf

## Finalize
rm -v ~/.bash_*
clear
printf "The installation finished succesfully. Install the appropriate graphics drivers and reboot the machine to get started.\n\n"
