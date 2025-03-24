# Set the path to the commitlint configuration file
export COMMITLINT_CONFIG_PATH=~/.config/commitlint/commitlint.config.js

# Add custom directories to the PATH environment variable
export PATH=$PATH:/var/data/python/bin:$HOME/.local/bin

# Set the location of the Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Disable Oh My Zsh auto-update
DISABLE_AUTO_UPDATE="true"

# Disable magic functions (optional, reduces overhead)
DISABLE_MAGIC_FUNCTIONS="true"

# Disable compatibility fix for completion (avoids warnings)
DISABLE_COMPFIX="true"

# Set the Zsh theme to "suvash"
ZSH_THEME="suvash"

# Enable spelling correction for commands
ENABLE_CORRECTION="true"

# Load Oh My Zsh plugins
plugins=(
    git                     # Git integration
    zsh-autosuggestions     # Suggests commands as you type
    colorize                # Colorizes file contents
    zsh-interactive-cd      # Interactive directory navigation
    zsh-syntax-highlighting # Highlights syntax in the terminal
)

# Source the main Oh My Zsh script
source $ZSH/oh-my-zsh.sh

# Configure completion behavior
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/cris/.zshrc'

# Initialize completion system
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

# Aliases for common commands
alias cat='ccat'                   
alias nrdev='npm run dev'          
alias ll='ls -la'                  
alias gs='git status'              
alias comp='cc -Wall -Wextra -Werror'      
alias c='clear'                    

# Function to delete a GitHub repository and its local folder
ghdel() {
    repo="$1"
    gh repo delete CristianValim/$1 --yes
    cd ..
    rm -rf "$1"
}

# Function to add, commit, and push changes to Git
gitproc() {
    commit_message="$1"
    git add . && git commit -m "$commit_message" && git push -u origin main
}

# Function to create a new GitHub repository and initialize it locally
ghnew() {
    if [ -z "$1" ]; then
        echo "Use: ghnew <repository-name>"
        return 1
    fi

    mkdir "$1" && cd "$1" || return 1

    git init

    gh repo create "$1" --public
    
    git remote add origin "git@github.com:CristianValim/$1.git"
    
    git branch -M main
}

# Load NVM (Node Version Manager) if installed
if [ -d "$NVM_DIR" ]; then
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi