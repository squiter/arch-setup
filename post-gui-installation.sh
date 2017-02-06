#!/bin/bash

function cprint {
    # Reset
    Color_Off='\033[0m'       # Text Reset

    # Regular Colors
    Black='\033[0;30m'        # Black
    Red='\033[0;31m'          # Red
    Green='\033[0;32m'        # Green
    Yellow='\033[0;33m'       # Yellow
    Blue='\033[0;34m'         # Blue
    Purple='\033[0;35m'       # Purple
    Cyan='\033[0;36m'         # Cyan
    White='\033[0;37m'        # White

    # Bold
    BBlack='\033[1;30m'       # Black
    BRed='\033[1;31m'         # Red
    BGreen='\033[1;32m'       # Green
    BYellow='\033[1;33m'      # Yellow
    BBlue='\033[1;34m'        # Blue
    BPurple='\033[1;35m'      # Purple
    BCyan='\033[1;36m'        # Cyan
    BWhite='\033[1;37m'       # White

    echo -e $2 $1 $Color_Off
}

cprint "Starting the post GUI installation..." $BGreen

cprint "==> SSH configuration..." $Grenn
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    cat /dev/zero | ssh-keygen -q -N ""

    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa

    echo "Key already copied to clipboard."
    xclip -sel clip < ~/.ssh/id_rsa.pub

    echo "Add this ssh key to your github account!"
    cat ~/.ssh/id_rsa.pub

    firefox --new-tab https://github.com/settings/keys &

    echo "Press [Enter] to continue..." && read
fi

cprint "==> Arch Setup..." $Green

if [ ! -d ~/code ]; then
    mkdir ~/code
    ln -s ~/code ~/projetos # temporary for compatibility
fi

cd ~/code
git clone git@github.com:squiter/arch-setup

cd arch-setup/dotfiles

cprint "-> Creating symlinks for dotfiles..." $Cyan
for item in $(ls -a); do
    if [ -f $item ];then
        ln -sf $(pwd)/$item ~/$item
    elif [ -d $item ]; then
        cp -as $(pwd)/$item ~/
    fi
done

cprint "-> Enable systemctl defaults" $Cyan
systemctl --user enable rescuetime

cprint "Done!" $BGreen
