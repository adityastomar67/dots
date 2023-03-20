#!/usr/bin/env bash
#  ╦═╗╦╔═╗╔═╗  ╦╔╗╔╔═╗╔╦╗╔═╗╦  ╦  ╔═╗╦═╗
#  ╠╦╝║║  ║╣   ║║║║╚═╗ ║ ╠═╣║  ║  ║╣ ╠╦╝
#  ╩╚═╩╚═╝╚═╝  ╩╝╚╝╚═╝ ╩ ╩ ╩╩═╝╩═╝╚═╝╩╚═
#   Author: https://github.com/gh0stzk
#   Redone by: https://github.com/adityastomar67

##--> Vars <--##
CRE=$(tput setaf 1)
CYE=$(tput setaf 3)
CGR=$(tput setaf 2)
CBL=$(tput setaf 4)
BLD=$(tput bold)
CNC=$(tput sgr0)
OK='\n\033[0;32m OK...\033[0m'
backup_folder=~/.RiceBackup
date=$(date +%Y%m%d-%H%M%S)
dependencies=(base-devel pacman-contrib bspwm polybar sxhkd
	tmux brightnessctl dunst rofi lsd
	jq polkit-gnome git playerctl mpd
	ncmpcpp geany ranger mpc picom
	feh ueberzug maim pamixer libwebp
	webp-pixbuf-loader xorg-xprop xorg-xkill physlock papirus-icon-theme
	ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-terminus-nerd ttf-inconsolata ttf-joypixels
	zsh zsh-history-substring-search)

##--> Check if it's running as root <--##
if [ "$(id -u)" = 0 ]; then
	echo "This script MUST NOT be run as root user."
	exit 1
fi

##--> Main Entry point of script <--##
_mainScript_() {
	logo "Welcome!"
	printf '%sThis script will install needed dependencies and copy my dotfiles to your bspwm setup.%s\n\nThis installer script does NOT change any configuration of your system.\nIts just a script that copies and moves my dotfiles to your ~/.config directory\n\n' "${CRE}" "${CNC}"
	sleep 5

	while true; do
		read -rp " Do you wish to continue? [y/N]: " yn
		case $yn in
		[Yy]*) break ;;
		[Nn]*) exit ;;
		*) printf " Error: just write 'y' or 'n'\n\n" ;;
		esac
	done
	clear
	install_pkg
	install_yay
	# install_stow
	setup_rice
	install_eww
	enable_services

	chsh -s /usr/bin/zsh
	zsh

	cd $HOME
	command rm -rf $HOME/.zshrc*
	command cp -rf $HOME/dotfiles/home/.zshrc $HOME/

	logo "Installation Finished!"
	printf "%sReboot is necessary, then choose bspwm in your login manager and login.%s\n" "${BLD}" "${CNC}"
	sleep 5
}

##--> Logo <--##
logo() {

	local text="${1:?}"
	echo -en "                                  
	               %%%                
	        %%%%%//%%%%%              
	      %%************%%%           
	  (%%//############*****%%
	%%%%%**###&&&&&&&&&###**//
	%%(**##&&&#########&&&##**
	%%(**##*****#####*****##**%%%
	%%(**##     *****     ##**
	   //##   @@**   @@   ##//
	     ##     **###     ##
	     #######     #####//
	       ###**&&&&&**###
	       &&&         &&&
	       &&&////   &&
	          &&//@@@**
	            ..***                
			  z0mbi3 Script (adityastomar67 fork)\n\n"
	printf ' %s [%s%s %s%s %s]%s\n\n' "${CRE}" "${CNC}" "${CYE}" "${text}" "${CNC}" "${CRE}" "${CNC}"
	sleep 2
}

##--> Check if the package is already installed or not <--##
is_installed() {
	pacman -Qi $1 &>/dev/null
	return $?
}

##--> Install necessary pkgs <--##
install_pkg() {
	printf "%s%sChecking for required packages...%s\n" "${BLD}" "${CBL}" "${CNC}"
	for package in "${dependencies[@]}"; do
		if ! is_installed $package; then
			sudo pacman -S $package --noconfirm
			printf "\n"
		else
			printf '%s%s is already installed on your system!%s\n' "${CGR}" "$package" "${CNC}"
			sleep 1
		fi
	done
	sleep 2
	clear
}

##--> Install AUR helper Yay <--##
install_yay() {
	logo "Checking if yay is installed"

	if ! command -v yay &>/dev/null; then
		printf "%s%sError YAY is not installed%s\n" "${BLD}" "${CRE}" "${CNC}"
		sleep 1
		printf "%s%sInstalling YAY..%s\n\n" "${BLD}" "${CYE}" "${CNC}"
		sleep 1
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si
		cd $HOME
		rm -rf yay
	else
		printf "%s%sYAY is already installed on your system%s\n" "${BLD}" "${CGR}" "${CNC}"
	fi
	sleep 2
	clear
}

##--> Install Eww for cool GUIs <--##
install_eww() {
	logo "Installing needed packages from AUR"
	yay -S eww --noconfirm --removemake --cleanafter
	sleep 2
	clear
}

##--> Install stow for dotfile management <--##
# install_stow() {

# }

##--> Setup the config file and backup old ones <--##
setup_rice() {
	##--> Cloning <--##
	logo "Cloning Rice!"
	[ -d ~/dotfiles ] && rm -rf ~/dotfiles
	printf "Cloning gh0stzk's rice. (adityastomar67 fork)\n\n"
	cd $HOME
	git clone --quiet --depth=1 https://github.com/adityastomar67/dots.git $HOME/dotfiles
	sleep 2
	clear

	##--> Backup <--##
	logo "Backup your files"
	printf "Backup files will be stored in %s%s%s/.RiceBackup%s \n\n" "${BLD}" "${CRE}" "$HOME" "${CNC}"
	sleep 5

	if [ ! -d "$backup_folder" ]; then
		mkdir -p "$backup_folder"
	fi

	for folder in bspwm alacritty picom rofi eww sxhkd dunst polybar ncmpcpp tmux nvim ranger tmux zsh mpd; do
		if [ -d "$HOME/.config/$folder" ]; then
			mv "$HOME/.config/$folder" "$backup_folder/${folder}_$date"
			echo "$folder folder backed up successfully at $backup_folder/${folder}_$date"
		else
			echo "The folder $folder does not exist in $HOME/.config/"
		fi
	done

	[ -f ~/.zshrc ] && mv ~/.zshrc ~/.RiceBackup/.zshrc-backup-"$(date +%Y.%m.%d-%H.%M.%S)"

	printf "%s%sDone!!%s\n" "${BLD}" "${CGR}" "${CNC}"
	sleep 4
	clear

	##--> Copy the Files <--##
	logo "Copying Rice.."
	printf "Copying files to respective directories..\n"

	[ ! -d ~/.config ] && mkdir -p ~/.config
	[ ! -d ~/.local/bin ] && mkdir -p ~/.local/bin
	[ ! -d ~/.local/share/applications ] && mkdir -p ~/.local/share/applications
	[ ! -d ~/.local/share/fonts ] && mkdir -p ~/.local/share/fonts
	[ ! -d ~/.local/share/asciiart ] && mkdir -p ~/.local/share/asciiart

	for archive in ~/dotfiles/config/*; do
		command cp -R ${archive} ~/.config/
		if [ $? -eq 0 ]; then
			printf "%s%s%s folder copied succesfully!%s\n" "${BLD}" "${CGR}" "${archive}" "${CNC}"
			sleep 1
		else
			printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archive}" "${CNC}"
			sleep 1
		fi
	done

	for archive in ~/dotfiles/misc/bin/*; do
		command cp -R ${archive} ~/.local/bin/
		if [ $? -eq 0 ]; then
			printf "%s%s%s file copied succesfully!%s\n" "${BLD}" "${CGR}" "${archive}" "${CNC}"
			sleep 1
		else
			printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archive}" "${CNC}"
			sleep 1
		fi
	done

	for archive in ~/dotfiles/misc/applications/*; do
		command cp -R ${archive} ~/.local/share/applications/
		if [ $? -eq 0 ]; then
			printf "%s%s%s file copied succesfully!%s\n" "${BLD}" "${CGR}" "${archive}" "${CNC}"
			sleep 1
		else
			printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archive}" "${CNC}"
			sleep 1
		fi
	done

	for archive in ~/dotfiles/misc/fonts/*; do
		command cp -R ${archive} ~/.local/share/fonts/
		if [ $? -eq 0 ]; then
			printf "%s%s%s copied succesfully!%s\n" "${BLD}" "${CGR}" "${archive}" "${CNC}"
			sleep 1
		else
			printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archive}" "${CNC}"
			sleep 1
		fi
	done

	for archive in ~/dotfiles/misc/asciiart/*; do
		command cp -R ${archive} ~/.local/share/asciiart/
		if [ $? -eq 0 ]; then
			printf "%s%s%s file copied succesfully!%s\n" "${BLD}" "${CGR}" "${archive}" "${CNC}"
			sleep 1
		else
			printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archive}" "${CNC}"
			sleep 1
		fi
	done

	command cp -rf $HOME/dotfiles/home/.zshrc $HOME/
	command cp -rf $HOME/dotfiles/home/.tmux.conf $HOME/
	fc-cache -rv >/dev/null 2>&1
	printf "%s%sFiles copied succesfully!!%s\n" "${BLD}" "${CGR}" "${CNC}"
	sleep 2
	clear
}

##--> Enable necessary services <--##
enable_services() {
	logo "Enabling MPD service"
	systemctl --user enable mpd.service
	systemctl --user start mpd.service
	printf "%s%sDone!!%s\n" "${BLD}" "${CGR}" "${CNC}"
	sleep 2
	clear
}

_mainScript_