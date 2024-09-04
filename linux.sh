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

# ZSH
link zsh/.zshrc ~ .zshrc

# TMUX
link tmux/.tmux.conf ~/.config/ .tmux.conf

# Neovim
link nvim ~/.config nvim

# Alacritty
link alacritty ~/.config/ alacritty

# Hyprland
link hypr ~/.config hypr
link dunst ~/.config dunst
link waybar ~/.config waybar

#
# MISC
#

# Wall papers
link wallpapers ~ wallpapers
