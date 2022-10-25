#!/bin/sh

# Arch Linux post-installation script

## Update system
sudo pacman -Syu

## Install git
sudo pacman -S git

## Install yay
git clone https://aur.archlinux.org/yay
cd yay
makepkg -si
cd
