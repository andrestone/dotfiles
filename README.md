# My Dotfiles

These are my personal dotfiles for Neovim and tmux. They are designed to be easily installed on macOS, Debian/Ubuntu, and Arch Linux.

## What's Inside?

### Automated Installation

The `install.sh` script automates the setup process. It will:

- **Detect your OS** and use the appropriate package manager (`brew`, `apt-get`, or `pacman`).
- **Install necessary packages**: `neovim`, `tmux`, and `git`.
- **Set up `oh-my-tmux`**: A powerful and beautiful tmux configuration.
- **Symlink the configuration files** for Neovim and tmux into the correct locations.
- **Install Neovim plugins**: Using the `lazy.nvim` plugin manager.

### Neovim Configuration (`nvim/init.lua`)

My Neovim setup is tailored for a modern development workflow, with a focus on LSP, autocompletion, and a great user experience.

- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) for fast and easy plugin management.
- **LSP**: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) for language server protocol support, with [mason.nvim](https://github.com/williamboman/mason.nvim) to automatically manage LSP servers.
- **Autocompletion**: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) for a powerful and extensible autocompletion engine.
- **Git Integration**: A suite of plugins including [vim-fugitive](https://github.com/tpope/vim-fugitive), [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), and [diffview.nvim](https://github.com/sindrets/diffview.nvim).
- **UI Enhancements**: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) for a beautiful statusline, [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) for indentation guides, and multiple color schemes.
- **Fuzzy Finding**: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for finding files, buffers, and more.
- **And much more**: Including a file tree, autopairs, commenting tools, and a debug adapter protocol (DAP) setup.

### Tmux Configuration (`.tmux.conf` and `.tmux.conf.local`)

My tmux configuration is based on the popular [oh-my-tmux](https://github.com/gpakosz/.tmux) project.

- **Plugin Manager**: [tpm](https://github.com/tmux-plugins/tpm) for managing tmux plugins.
- **Session Persistence**: [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) to save and restore tmux sessions across reboots.
- **Customizable Appearance**: A custom theme with a clear and informative status line.
- **Sensible Keybindings**: A set of keybindings for easy navigation and window management.

## Installation

1.  Clone this repository:
    ```bash
    git clone https://github.com/your-username/dotfiles.git ~/.dotfiles
    ```
2.  Run the installation script:
    ```bash
    ~/.dotfiles/install.sh
    ```

The script will handle the rest. Enjoy!