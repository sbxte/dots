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

symlink() {
	#
	# .config
	#

	echo "Creating .config symlinks..."

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

	# Systemd
	link systemd ~/.config systemd

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

	echo "Finished creating .config symlinks!"

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
			gdm hyprland swaync waybar nautilus wofi hyprpaper pipewire wireplumber \
			nerd-fonts acpilight ibus exa eza tlp playerctl bluez bluez-utils
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
	echo "Run with install, or symlink"
	exit
fi

# Ask for password upfront
if command -v sudo 2>&1 >/dev/null; then
	echo "Sudo not found!"
	exit
fi
sudo -v

if [[ "$1" == "s" || "$1" == "symlink" ]]; then
	symlink
	exit
fi

if [[ "$1" == "i" || "$1" == "install" ]]; then
	install
	exit
fi
