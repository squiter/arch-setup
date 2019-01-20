#!/bin/bash -ev

sudo pacman -Su --noconfirm
sudo pacman -S --noconfirm --needed git
# sudo pacman -S --noconfirm --needed ansible

# aura-bin dependency
sudo pacman -S --noconfirm --needed abs
sudo pacman -S --noconfirm --needed curl

if [[ ! $(command -v aura) ]]
then
    echo "Installing Aura"
    cd /tmp
    curl aur.sh | bash -si aura-bin
    echo Y | sudo pacman -U aura-bin/aura-bin*.tar.xz
    cd -
fi

sudo aura -Ayu --noconfirm

echo "Installing X"
sudo pacman -S --noconfirm --needed xorg-server
sudo pacman -S --noconfirm --needed xorg-xinit xorg-utils xorg-server-utils mesa xorg-twm xterm xorg-xclock

echo "Installing Gnome"
sudo pacman -S --noconfirm --needed gnome gnome-extra gdm

echo "Installing Network Packages"
sudo pacman -S --noconfirm --needed net-tools
sudo pacman -S --noconfirm --needed networkmanager
sudo pacman -S --noconfirm --needed network-manager-applet

echo "Installing fonts"
sudo pacman -S --noconfirm --needed ttf-dejavu
sudo pacman -S --noconfirm --needed terminus-font
sudo pacman -S --noconfirm --needed ttf-symbola       # allow emoji
sudo pacman -S --noconfirm --needed ttf-inconsolata
sudo aura   -A --noconfirm --needed ttf-font-awesome  # icons for status bars

echo "Installing Developer Tools"
sudo pacman -S --noconfirm --needed base-devel
sudo pacman -S --noconfirm --needed openssh
sudo pacman -S --noconfirm --needed git
sudo pacman -S --noconfirm --needed emacs
sudo pacman -S --noconfirm --needed vim
sudo pacman -S --noconfirm --needed xclip
sudo pacman -S --noconfirm --needed bash-completion # confirm!
sudo pacman -S --noconfirm --needed terminator
sudo pacman -S --noconfirm --needed the_silver_searcher
sudo aura   -A --noconfirm --needed rbenv ruby-build
sudo aura   -A --noconfirm --needed peco

echo "Installing Languages"
sudo pacman -S --noconfirm --needed ruby

echo "Docker"
sudo pacman -S --noconfirm --needed docker
sudo pacman -S --noconfirm --needed docker-compose

echo "Installing common software"
sudo pacman -S --noconfirm --needed gimp
sudo pacman -S --noconfirm --needed inkscape
# sudo pacman -S --noconfirm --needed pidgin
sudo aura   -A --noconfirm --needed dropbox
# sudo aura   -A --noconfirm --needed forticlientsslvpn

echo "installing dictionary apps"
sudo pacman -S --noconfirm --needed aspell
sudo pacman -S --noconfirm --needed aspell-en
sudo pacman -S --noconfirm --needed aspell-pt

echo "Installing video software"
sudo pacman -S --noconfirm --needed vlc

echo "Installing browsers"
sudo aura -A   --noconfirm --needed google-chrome
sudo pacman -S --noconfirm --needed firefox
sudo aura -A   --noconfirm --needed google-talkplugin
sudo aura -A   --noconfirm --needed lastpass
sudo aura -A   --noconfirm --needed lastpass-cli

echo "Installing productivity related software"
sudo aura -A --noconfirm --needed rescuetime
sudo aura -A --noconfirm --needed gnome-shell-extension-caffeine-git
sudo aura -A --noconfirm --needed gnome-shell-extension-pixel-saver

echo "Activate needed services"
sudo systemctl enable NetworkManager.service
sudo systemctl enable gdm

echo "Installing PIP and Wakatime"
curl -O https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
rm get-pip.py
sudo pip install wakatime

echo "Updating all packages"
sudo pacman -Syu --noconfirm

echo "Downloading the post-gui-installation.sh"
curl -s https://raw.githubusercontent.com/squiter/arch-setup/master/post-gui-installation.sh > post-gui-installation.sh
chmod +x post-gui-installation.sh

echo "================================================================================"
echo "Now you have a post-gui-installation.sh copied in your home directory."
echo "Reboot your PC and run this shell script to finish the installation."
echo "================================================================================"

echo "Done!"
exit 0
