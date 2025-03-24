#!/bin/bash

# Get the directory of the script
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Update the system and repositories
echo "Updating the system..."
sudo apt update && sudo apt upgrade -y

echo "Removing unnecessary applications..."
sudo apt-get autoremove --purge \
    geary \
    gedit \
    gnome-calendar \
    gnome-contacts \
    gnome-weather \
    libreoffice-* -y
echo "Unnecessary applications removed successfully!"

# Install basic packages and utilities
echo "Installing basic packages..."
sudo apt install -y \
    build-essential \
    curl \
    wget \
    git \
    gnome-tweaks \
    htop \
    unzip \
    zip \
    tree \
    software-properties-common

# Install development tools
echo "Installing development tools..."
sudo apt install -y \
    python3 \
    python3-pip \
    python3-venv \
    nodejs \
    npm

# Configure Git
echo "Configuring Git..."
git config --global user.name "Cristian Valim"
git config --global user.email "cristianvalimdasilva@gmail.com"
git config --global init.defaultBranch main

# Install Powerline fonts for the terminal
echo "Installing Powerline fonts..."
sudo apt install -y fonts-powerline

echo "Installing and setting Zsh as the default shell..."
sudo apt install -y zsh
chsh -s $(which zsh) $USER

# Install and configure Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
else
    echo "Oh My Zsh is already installed. Skipping..."
fi

# Set ZSH_CUSTOM if not already set
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# Install zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo "zsh-autosuggestions is already installed. Skipping..."
fi

# Install zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    echo "zsh-syntax-highlighting is already installed. Skipping..."
fi

# Use the zshrc file from the script's directory
echo "Replacing the default .zshrc with the custom one..."
cp "$SCRIPT_DIR/zshrc" ~/.zshrc

# Install NVM and Node.js
echo "Installing NVM and Node.js..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts

# Download and install Visual Studio Code
echo "Downloading Visual Studio Code..."
wget -qO vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
echo "Installing Visual Studio Code..."
sudo dpkg -i vscode.deb
rm vscode.deb

# Download the wallpaper from the repository
echo "Downloading the wallpaper..."
WALLPAPER_URL="https://raw.githubusercontent.com/CristianValim/Pop_OS_Setup/main/Wallpaper.jpg"
WALLPAPER_PATH="$HOME/Desktop/Wallpaper.jpg"

curl -fsSL "$WALLPAPER_URL" -o "$WALLPAPER_PATH"

# Fix dependencies
echo "Fixing dependencies..."
sudo apt install -f -y

# Clean up unnecessary packages
echo "Cleaning up unnecessary packages..."
sudo apt autoremove -y

echo "Setup completed successfully!"
read -p "Do you want to restart now? (y/N): " restart
if [[ "$restart" =~ ^[Yy]$ ]]; then
    sudo reboot
fi