#!/usr/bin/env bash

# Ask for password upfront
sudo -v

# Sym link helper
link() {
	TARGET=$1
	DIR=$2
	LINK=$3
	FULL_LINK="$DIR/$LINK"

	# Remove link if it exists
	if [ -f "$FULL_LINK" ]; then
		rm "$FULL_LINK"
	elif [ -d "$FULL_LINK" ]; then
		rm -rf "$FULL_LINK"
	fi

	# Create symbolic link
	mkdir -p "$DIR"
	ln -rsf "$TARGET" "$FULL_LINK"
}

# GIT
link git/linux.gitconfig ~ .gitconfig

# Oh My Posh
link omp/omp.json ~ .omp.json

# ZSH
link zsh/.zshrc ~ .zshrc

link zsh/git-completion.bash ~/.zsh git-completion.bash
link zsh/git-completion.zsh ~/.zsh _git

# TMUX
link tmux/.tmux.conf ~ .tmux.conf

# Neovim
link nvim ~/.config nvim

# Alacritty
link alacritty/.alacritty.toml ~ .alacritty.toml

# Hyprland
link hyprland ~/.config hypr

# Eww
link eww ~/.config eww

#
# MISC
#

# Wall papers
link wallpapers ~ wallpapers
