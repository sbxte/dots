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
link swaync ~/.config swaync
link waybar ~/.config waybar

# Cava
link cava ~/.config cava

#
# MISC
#

# Wall papers
link wallpapers ~ wallpapers

# Install needed packages
. /etc/os-release

case $ID in
arch)
	sudo pacman -S --noconfirm --needed base-devel git zsh neovim alacritty hyprland swaync waybar thunar wofi hyprpaper pamixer pavucontrol \
		nerd-fonts acpilight ibus exa eza tlp playerctl
	if ! command -v yay &>/dev/null; then
		pacman -S --needed git base-devel
		git clone https://aur.archlinux.org/yay-bin.git
		cd yay-bin
		makepkg -si
		cd ..
		rm -rf yay-bin
	fi
	sudo yay -S --noconfirm --needed hyprshot ibus-daemon
	;;

*)
	echo "Hmm, new distro?"
	;;
esac
