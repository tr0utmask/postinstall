#!/bin/sh

# Arch Linux post-installation script

## Go home
cd

## Update system
sudo pacman -Syu

## Install git
sudo pacman -S git

## Install yay
git clone https://aur.archlinux.org/yay
cd yay
makepkg -si
cd

## When yay is installed, install the necessary packages
yay -S adobe-source-han-sans-otc-fonts dunst feh firefox gnome-themes-extra gtk-engines gvim htop libnotify lxappearance mpv mupdf pulseaudio pulseaudio-alsa pulsemixer rxvt-unicode scrot thunar ttf-go-sans-git ttf-ms-fonts tumbler unrar unzip xorg-fonts-misc xorg-server xorg-xinit xorg-xrandr xorg-xset xorg-xsetroot yt-dlp

printf "\nPlease install the appropriate graphics drivers yourself.\n"

## Clone dotfiles repo
git clone https://github.com/tr0utmask/dotfiles

## Build suckless utilities
