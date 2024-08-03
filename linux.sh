#!/usr/bin/env bash

# Ask for password upfront
sudo -v

# GIT
ln -rsf git/linux.gitconfig ~/.gitconfig

mkdir -p ~/.zsh
cp zsh/git-completion.bash ~/.zsh
cp zsh/git-completion.zsh ~/.zsh/_git

# Oh My Posh
ln -rsf omp/omp.json ~/.omp.json

# ZSH
ln -rsf zsh/.zshrc ~/.zshrc
source zsh/.zshrc

# TMUX
ln -rsf tmux/.tmux.conf ~/.tmux.conf

# Neovim
ln -rsf nvim ~/.config/nvim
