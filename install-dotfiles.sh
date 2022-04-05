#!/usr/bin/env bash
read -p "Please provide your username: " CURRENTUSER
DIR=${PWD}

# FOR DEBIAN/UBUNTU BASED SYSTEMS WITH ROOT PERMISSION
# REQUIRED NERD FONT: Download one and isntall from https://www.nerdfonts.com/

if ! [[ $SHELL == '/usr/bin/zsh' ]]; then
    echo "The script will now install ZSH."
    sudo apt update && sudo apt install -y zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    exec "./"$0""
fi

CURRENTHOME=$(eval echo "~$CURRENTUSER")
curl -L git.io/antigen > "CURRENTHOME"/antigen.zsh

sudo -i -u $CURRENTUSER bash << EOF
echo "Running as user: "$CURRENTUSER""
echo ""$CURRENTUSER" home directory is: "$CURRENTHOME""
# RUST AND RUST-BASED TOOLS
status=$?
cargo --version

if [[ "$status" -eq 1 ]]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    exec "./"$0""
else
    echo "Rust language is already installed. Skipping..."
fi

curl -sS https://starship.rs/install.sh | sh

cargo install exa

cp -r -v -b "$DIR"/.bashrc "$CURRENTHOME"
cp -r -v -b "$DIR"/.zshrc "$CURRENTHOME"
cp -r -v -b "$DIR"/.config/ "$CURRENTHOME"
rm "$CURRENTHOME"/install-dotfiles.sh

EOF

echo "Exiting user: "$CURRENTUSER""

echo "If you get this message everything should be installed"
read -p "Confirm if you got the message [y/n]: " bool

if [[ $bool == 'y' || $bool == 'yes' ]]; then
    echo "Installation confirmed"; exit 0
else
    echo "Rerun \$ sudo bash install-dotfiles.sh"; exit 1
fi