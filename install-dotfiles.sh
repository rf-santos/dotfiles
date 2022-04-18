#!/usr/bin/env bash

echo "This script will install a couple of tools for better terminal experience"
echo "After installing Oh-My-Bash and Oh-My-Zsh you will need to hit [Ctrl + D] or even run the script again (ignoring previous errors)"
echo "Respond yes to any interactive question from the installers"

read -p "Confirm if you got the message [y/n]: " bool

if [[ $bool == 'y' || $bool == 'yes' ]]; then
    echo "Starting installation"
else
    echo "Rerun \$ bash install-dotfiles.sh"; exit 1
fi

DIR=${PWD}
echo $USER
if ! [[ -d "~/.oh-my-bash" ]]; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
fi

# FOR DEBIAN/UBUNTU BASED SYSTEMS WITH ROOT PERMISSION
# REQUIRED NERD FONT: Download one and isntall from https://www.nerdfonts.com/

if ! [[  $(which zsh) == '/usr/bin/zsh' ]]; then
    echo "The script will now install ZSH."
    sudo apt update && sudo apt install -y coreutils curl build-essential zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    exec "./"$0""
fi

echo "Running as user: "$USER""
echo ""$USER" home directory is: ~"

# RUST AND RUST-BASED TOOLS

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

curl -sS https://starship.rs/install.sh | sh

cargo install exa

cp -r -v -b "$DIR"/.bashrc ~
cp -r -v -b "$DIR"/.zshrc ~
cp -r -v -b "$DIR"/.config/ ~

echo "Exiting user: "$USER""

curl -L git.io/antigen > ~/antigen.zsh
source ~/.zshrc
source ~/antigen.zsh

echo "If you get this message everything should be installed"
read -p "Confirm if you got the message [y/n]: " bool

if [[ $bool == 'y' || $bool == 'yes' ]]; then
    echo "Installation confirmed. Please restart your shell"; exit 0
else
    echo "Rerun \$ sudo bash install-dotfiles.sh"; exit 1
fi

echo "Done"