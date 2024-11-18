#!/bin/bash

# Atualiza o sistema e os repositórios
echo "Atualizando o sistema..."
sudo apt update && sudo apt upgrade -y

echo "Removendo aplicativos desnecessários..."
sudo apt-get autoremove --purge \
    geary \
    gedit \
    gnome-calendar \
    gnome-contacts \
    gnome-weather \
    libreoffice-* -y
echo "Aplicativos desnecessários removidos com sucesso!"

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

# Configurando Zsh com plugins e tema
echo "Configurando Zsh com plugins e tema..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
cat <<EOL > ~/.zshrc
# Configuração do PATH
export PATH="\$HOME/bin:\$HOME/.local/bin:/usr/local/bin:\$PATH"

# Caminho para a instalação do Oh My Zsh
export ZSH="\$HOME/.oh-my-zsh"

# Configuração de idioma e localização
export LANG=pt_BR.UTF-8
export LC_ALL=pt_BR.UTF-8
export LC_MESSAGES=pt_BR.UTF-8

# Definição do tema do Oh My Zsh
ZSH_THEME="suvash"

# Habilitar correção automática de comandos
ENABLE_CORRECTION="true"

# Plugins a serem carregados
plugins=(
  git
  zsh-autosuggestions
  colored-man-pages
  colorize
  git-commit
)

# Carregar o Oh My Zsh
source \$ZSH/oh-my-zsh.sh

source ~/.config/zsh/git_functions.sh

# Configuração do less para terminal colorido
less_termcap[md]="\${fg_bold[blue]}"

# Configuração de autocompletar (adicionado pelo compinstall)
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/$USER/.zshrc'

autoload -Uz compinit
compinit

# Carregar o zsh-syntax-highlighting se o arquivo existir
if [ -f "\$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "\$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Configuração do NVM (Node Version Manager)
export NVM_DIR="\$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"  # Carrega o nvm
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"  # Carrega a conclusão automática do nvm

# Definição de aliases
alias nrdev="npm run dev"
alias ll="ls -la"
alias gs="git status"
alias gls="git ls-files"
alias comp='cc -Wall -Wextra -Werror'
alias cat='batcat'

alias norm='norminette'
alias c='clear'
EOL

# Instalando zsh-syntax-highlighting, se necessário
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "Instalando zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# Instalação de NVM e Node.js
echo "Instalando NVM e Node.js..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts

# Instalação de aplicativos de comunicação e desenvolvimento
echo "Baixando o Rambox..."
wget -qO rambox.deb "https://rambox.app/api/download?os=linux&package=deb"
echo "Instalando o Rambox..."
sudo dpkg -i rambox.deb
rm rambox.deb

echo "Baixando o Visual Studio Code..."
wget -qO vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
echo "Instalando o Visual Studio Code..."
sudo dpkg -i vscode.deb
rm vscode.deb

echo "Instalando Beekeeper Studio..."
sudo flatpak install --system flathub io.beekeeperstudio.Studio -y

echo "Instalando Insomnia..."
sudo flatpak install --system flathub rest.insomnia.Insomnia -y

# Corrigir dependências
echo "Corrigindo dependências..."
sudo apt install -f -y

# Limpeza
echo "Limpando pacotes desnecessários..."
sudo apt autoremove -y

echo "Configuração finalizada! Por favor, reinicie seu terminal ou faça logout/login para aplicar todas as alterações."
