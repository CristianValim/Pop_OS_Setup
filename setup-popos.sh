#!/bin/bash

# Atualiza o sistema e os repositórios
echo "Atualizando o sistema..."
sudo apt update && sudo apt upgrade -y

# Instalação de pacotes básicos e utilitários
echo "Instalando pacotes básicos..."
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

# Instalação de navegadores
echo "Instalando navegadores..."
sudo apt install -y firefox

# Instalação de pacotes de desenvolvimento
echo "Instalando ferramentas de desenvolvimento..."
sudo apt install -y \
    python3 \
    python3-pip \
    python3-venv \
    nodejs \
    npm


# Instalação de gerenciadores de pacotes adicionais
echo "Instalando gerenciadores de pacotes adicionais..."
sudo apt install -y flatpak

# Configurar repositório Flathub para Flatpak
echo "Configurando Flathub para Flatpak..."
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Instalação de ferramentas de linha de comando
echo "Instalando ferramentas de linha de comando..."
sudo apt install -y \
    zsh \
    tmux \
    neofetch \
    fzf \
    bat

# Instalação de fonte Powerline para o terminal
echo "Instalando fonte Powerline..."
sudo apt install -y fonts-powerline


# Instalação de aplicativos de comunicação e desenvolvimento

echo "Baixando o Rambox..."
wget -qO rambox.deb "https://rambox.app/api/download?os=linux&package=deb"

# Instalar o pacote .deb
echo "Instalando o Rambox..."
sudo dpkg -i rambox.deb

# Remover o pacote .deb após a instalação
rm rambox.deb

echo "Baixando o Visual Studio Code..."
wget -qO vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868

# Instalar o pacote .deb
echo "Instalando o Visual Studio Code..."
sudo dpkg -i vscode.deb

echo "Instalando Beekeeper Studio..."
sudo flatpak install --system flathub io.beekeeperstudio.Studio -y

echo "Instalando Insomnia..."
sudo flatpak install --system flathub rest.insomnia.Insomnia -y

# Remover o pacote .deb após a instalação
rm vscode.deb

# Corrigir dependências, se necessário
echo "Corrigindo dependências..."
sudo apt install -f -y

# Limpeza
echo "Limpando pacotes desnecessários..."
sudo apt autoremove -y

echo "Configuração finalizada! Por favor, reinicie seu terminal ou faça logout/login para aplicar todas as alterações."

