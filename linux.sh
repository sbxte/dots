#!/usr/bin/env bash

# Ask for password upfront
sudo -v

# GIT CONFIG
ln -rsf git/linux.gitconfig ~/.gitconfig

# ZSH
ln -rsf zsh/.zshrc ~/.zshrc

# TMUX
ln -rsf tmux/.tmux.conf ~/.tmux.conf
