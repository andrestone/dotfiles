#!/usr/bin/env bash
# install.sh — set up Neovim, tmux, plugin managers, and dotfile symlinks
# Works on macOS, Debian/Ubuntu, and Arch Linux out of the box.

set -euo pipefail

# ---- helpers --------------------------------------------------------------
info()  { printf "\033[1;34m[INFO]\033[0m  %s\n" "$*"; }
warn()  { printf "\033[1;33m[WARN]\033[0m  %s\n" "$*"; }
error() { printf "\033[1;31m[ERROR]\033[0m %s\n" "$*"; exit 1; }

# ---- detect OS & pick a package manager -----------------------------------
CPUTYPE=$(uname -m)
OS=$(uname -s)
PM=""          # package manager name
INST=""        # install command (string we eval)
DOTFILES_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

install_neovim() {
    info "Installing Neovim..."
    sudo rm -rf $DOTFILES_ROOT/nvim-linux-$CPUTYPE.tar.gz
    sudo rm -rf /opt/nvim /usr/local/bin/nvim /usr/local/bin/vim $DOTFILES_ROOT/nvim-linux-$CPUTYPE.tar.gz || echo
    sudo curl -LO -o $DOTFILES_ROOT/nvim-linux-$CPUTYPE.tar.gz "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$CPUTYPE.tar.gz"
    sudo tar -C /opt -xzf "nvim-linux-$CPUTYPE.tar.gz"
    sudo ln -s "/opt/nvim-linux-$CPUTYPE/bin/nvim" /usr/local/bin/nvim
    sudo ln -s "/opt/nvim-linux-$CPUTYPE/bin/nvim" /usr/local/bin/vim
}

maybe_install_nvm() {
    if command -v nvm >/dev/null 2>&1; then
        info "nvm is already installed."
        return
    fi
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    nvm install --lts
}

if [[ $OS == "Darwin" ]]; then
    PM="brew"
    if ! command -v brew >/dev/null 2>&1; then
        info "Homebrew missing → installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv || true)"
    fi
    brew update
    if ! command -v go >/dev/null 2>&1; then
        brew install go
    fi
    brew install tmux neovim git

elif [[ $OS == "Linux" ]]; then
    if   command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update
        sudo apt-get install -y tmux git
        install_neovim

    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -Syu --noconfirm tmux git
        install_neovim
    else
        # try yum
        if command -v yum >/dev/null 2>&1; then
            sudo yum install -y tmux git
            install_neovim
        else
            error "Unsupported Linux distro: no apt-get, pacman, or yum found."
        fi
    fi
else
    error "Unsupported OS: $OS"
fi

# ---- ensure oh-my-tmux is installed ----------------------------------------
git submodule update --init --recursive

# ---- variables -------------------------------------------------------------
NVIM_CFG="$HOME/.config"
TMUX_CFG="$HOME"

# ---- create required directories ------------------------------------------
mkdir -p "$HOME/.config" "$NVIM_CFG" "$TMUX_CFG"

# ---- symlink configs -------------------------------------------------------
info "Linking Neovim and tmux configs…"
ln -snf "$DOTFILES_ROOT/nvim" "$NVIM_CFG"
ln -snf "$DOTFILES_ROOT/tmux/.tmux/.tmux.conf" "$TMUX_CFG/.tmux.conf"
ln -snf "$DOTFILES_ROOT/tmux/.tmux.conf.local" "$TMUX_CFG/.tmux.conf.local"
ln -snf "$DOTFILES_ROOT/tmux/.tmux" "$TMUX_CFG"

# ---- Neovim plugin manager (lazy.nvim) -------------------------------------
# lazy.nvim will automatically install itself and plugins on first run
info "Neovim setup complete. Plugins will be installed automatically on first run via lazy.nvim."

# ---- home dotfiles --------------------------------------------------------
info "Linking home dotfiles…"
ln -snf "$DOTFILES_ROOT/home/.gitconfig" "$HOME/.gitconfig"

# ---- nvm (Node Version Manager) --------------------------------------------
maybe_install_nvm
