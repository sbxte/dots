#!/usr/bin/env bash

# Sym link helper
link() {
	TARGET=$1
	DIR=$2
	LINK=$3
	FULL_LINK="$DIR/$LINK"

	# Remove link if it exists
	if [ -f "$FULL_LINK" ]; then
		if rm -f "$FULL_LINK" 2>/dev/null; then
			echo "Removed file $FULL_LINK"
		else
			sudo -v
			sudo rm -f "$FULL_LINK"
			echo "(sudo) Removed file $FULL_LINK"
		fi
	elif [ -d "$FULL_LINK" ]; then
		if rm -rf "$FULL_LINK" 2>/dev/null; then
			echo "Removed dir $FULL_LINK"
		else
			sudo -v
			sudo rm -rf "$FULL_LINK"
			echo "(sudo) Removed dir $FULL_LINK"
		fi
	fi

	# Create symbolic link
	mkdir -p "$DIR"
	if ln -rsf "$TARGET" "$FULL_LINK" 2>/dev/null; then
		echo "Created symlink $FULL_LINK -> $TARGET"
	else
		sudo -v
		sudo ln -rsf "$TARGET" "$FULL_LINK"
		echo "(sudo) Created symlink $FULL_LINK -> $TARGET"
	fi
}

# Copy helper
copy() {
	TARGET=$1
	DIR=$2

	if cp -rf "$TARGET" "$DIR" 2>/dev/null; then
		echo "Copied $TARGET -> $DIR"
	else
		sudo -v
		sudo cp -rf "$TARGET" "$DIR"
		echo "(sudo) Copied $TARGET -> $DIR"
	fi
}

config() {
	#
	# /etc
	#

	echo "Copying configs /etc"

	# Root systemd
	link systemd/system/user-sleep@.service /etc/systemd/system user-sleep@.service
	link systemd/system/fix-elan-touchpad.service /etc/systemd/system fix-elan-touchpad.service

	# Greetd
	copy greetd /etc

	echo "Finished copying configs to /etc!"

	#
	# .config
	#

	echo "Creating .config and ~ symlinks..."

	# BASH
	link bash/.bashrc ~ .bashrc

	# GIT
	link git/linux.gitconfig ~ .gitconfig

	# ZSH
	link zsh/.zshrc ~ .zshrc
	link omz ~ .omz-custom

	# Nushell
	link nushell ~/.config nushell

	# TMUX
	link tmux/.tmux.conf ~/.config/ .tmux.conf

	# User Systemd
	link systemd/user ~/.config/systemd user

	# Neovim
	link nvim ~/.config nvim

	# Kitty
	link kitty ~/.config/ kitty

	# Alacritty
	link alacritty ~/.config/ alacritty

	# Desktop Environment
	link hypr ~/.config hypr
	link niri ~/.config niri
	link swaync ~/.config swaync
	link waybar ~/.config waybar
	link sunsetr ~/.config sunsetr

	# Cava
	link cava ~/.config cava

	# XCompose
	link xcompose/.XCompose ~ .XCompose

	# Clangd
	link clangd ~/.config clangd

	# GNU
	link gnu/.gdbinit ~ .gdbinit

	echo "Finished creating .config and ~ symlinks!"

	#
	# MISC
	#

	echo "Creating additional symlinks..."

	# Wall papers
	link wallpapers ~ wallpapers

	echo "Finished creating additional symlinks!"
}

install() {
	echo "Installing needed packages"

	. /etc/os-release

	case $ID in
	arch)
		sudo pacman -S --noconfirm --needed base-devel git zsh neovim alacritty \
			gdm hyprland swaync waybar nautilus wofi hyprpaper hyprlock pipewire wireplumber xwayland-satellite \
			nerd-fonts acpilight ibus exa eza tlp playerctl bluez bluez-utils bc
		if ! command -v yay &>/dev/null; then
			pacman -S --needed git base-devel
			git clone https://aur.archlinux.org/yay-bin.git
			cd yay-bin
			makepkg -si
			cd ..
			rm -rf yay-bin
		fi
		sudo yay -S --noconfirm --needed uwsm hyprshot ibus-daemon xwaylandvideobridge bluetui
		;;

	*)
		echo "Hmm, new distro?"
		;;
	esac
}

#
# Actual script lol
#

if [ "$#" -eq 0 ]; then
	echo "Run with install, or config"
	exit
fi

# Ask for password upfront
if ! command -v sudo 2>&1 >/dev/null; then
	echo "Sudo not found!"
	exit
fi
sudo -v

if [[ "$1" == "c" || "$1" == "config" ]]; then
	config
	exit
fi

if [[ "$1" == "i" || "$1" == "install" ]]; then
	install
	exit
fi
