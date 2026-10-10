# techno-sam's nvim config

## Notes

This is here for the curious, no support will be given.

I run this on Ubuntu, but other linuxes and perhaps even other OSes should work too.

## Installing

0. don't

1. [install neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md). You'll be wanting the bleeding-edge nightly release.

2. Install **clangd**: either with your system package manager, or from within neovim using `:Mason`

3. Install **rust-analyzer**: do this through rustup so it matches your toolchain

4. Install [tree-sitter-cli 0.26.1 or later](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md): with your system package manager, you need this before install starts

4. Optionally install [lazygit](https://github.com/jesseduffield/lazygit)

5. If you have an existing nvim config, move it out of the way: `mv ~/.config/nvim ~/.config/nvim.$(date '+%Y%m%d-%H%M%S').bak`  
   You may also want to move your `~/.local/share/nvim` and possibly `~/.local/state/nvim`, but this might not be necessary.

6. Clone this thing: `git clone https://github.com/techno-sam/nvim-config.git ~/.config/nvim`

7. Run nvim. Lazy should install itself and all plugins. Run `:Mason` and wait for everything to install. Quit and reopen nvim to ensure everything loads properly.
