#!/bin/sh

# Arch Linux / Debian post-installation script

## Go home
cd ~ || exit

## Determine which OS we're running
if [ "$(pacman -V)" ]
then

	# Arch-specific tasks

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
	yay -S adobe-source-han-sans-otc-fonts bash-completion dunst feh firefox gnome-themes-extra gtk-engines gvim htop libnotify lxappearance mpv mupdf pulseaudio pulseaudio-alsa pulsemixer rxvt-unicode scrot thunar ttf-go-sans-git ttf-ms-fonts tumbler unrar unzip xcape xorg-fonts-misc xorg-server xorg-xinit xorg-xrandr xorg-xset xorg-xsetroot yt-dlp

elif [ "$(apt -v)" ]
then

	# Debian-specific tasks

	## Update system
	sudo apt update && sudo apt upgrade

	## Install necessary packages
	sudo apt install bash-completion curl dunst feh firefox-esr fonts-go git gnome-themes-extra gtk2-engines htop lm-sensors lxappearance mpv mupdf pulseaudio pulsemixer rxvt-unicode scrot thunar unrar-free unzip vim-gtk3 x11-xserver-utils xcape xinit xserver-xorg-core

	## Install yt-dlp
	sudo wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp
	sudo chmod a+rx /usr/local/bin/yt-dlp

	## Temporarily enable contrib repos and install MS fonts
	echo "deb http://ftp.de.debian.org/debian bullseye main contrib" | sudo tee -a /etc/apt/sources.list
	sudo apt update
	sudo apt install ttf-mscorefonts-installer
	sudo sed -i '/ftp/d' /etc/apt/sources.list

	## Allow use of bitmap fonts
	sudo rm -v /etc/fonts/conf.d/*bitmap*

else

	echo "You seem to be using an unsupported operating system. Only Arch Linux and Debian are officially supported. Their derivatives may also work, but support for them is not guaranteed." && exit

fi

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
