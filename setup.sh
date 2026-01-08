#!/usr/bin/bash

# Dependencies
sudo apt install exuberant-ctags python3-pynvim clangd rgrep
# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# Autorun :PlugInstall
# TODO
# Compile ycm
# TODO
