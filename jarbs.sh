#!/bin/sh

# JARBS (Jim's Auto-Ricing Bootstrapping Script) is a script meant to setup my dotfiles, inspired by Luke Smith's LARBS.
# Contributors: drquadriple
# License: GNU GPLv3

# Colour variables
b=$(tput bold)     # Bold
r=$(tput setaf 1)  # Red
g=$(tput setaf 2)  # Green

# Introduction
echo "Welcome To JARBS (Jim's Auto-Rice Bootstrapping Script)!
Please know this script only functions on Arch and Arch-based Linux Systems.
JARBS does not have any warranty and is not responsible for any damage to your system."

# JARBS User Prompt
# shellcheck disable=SC2162
read -p "${b}Do you understand? [y/N]: " yn
    case $yn in
        [Yy]*) echo "${g}Installing Jarbs.";;
        *) echo "${r}Quitting JARBS." && exit;;
    esac

# Step 0: Create JARBS Cache Directory
mkdir -p ~/.cache/JARBS
cd ~/.cache/JARBS || exit

# Step 0.5: Preparation
echo "${b}- Installing Git."
sudo pacman -Sy --needed --noconfirm git
echo "${b}- Cloning the dotfiles."
git clone https://github.com/JimPix1/dotfiles/
echo "${b}- Installing YAY."
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..

# Step 1: DWM Installation
echo "${b}- Installing DWM."
yay -S libxft-bgra
mkdir -p ~/.config
mv -f dotfiles/config/dwm ~/.config/dwm
sudo make install ~/.config/dwm

# Step 2: St Installation
echo "${b}- Installing st (suckless terminal)."
mv -f dotfiles/config/st ~/.config/st
sudo make install ~/.config/st

# Step 3: Dwmblocks Installation
echo "${b}- Installing Dwmblocks."
mv -f dotfiles/config/dwmblocks ~/.config/dwmblocks
sudo make install ~/.config/dwmblocks

# Step 4: Dmenu Installation
echo "${b}- Installing Dmenu."
mv -f dotfiles/config/dmenu ~/.config/dmenu
sudo make install ~/.config/dmenu

# Step 5: Picom Installation
echo "${b}- Installing Picom."
sudo pacman -S --needed --noconfirm picom
mv -f dotfiles/config/picom ~/.config/picom

# Step 6: Theming
echo "${b}- Configuring Theming."
sudo pacman -S --needed --noconfirm materia-gtk-theme
sudo pacman -S --needed --noconfirm papirus-icon-theme
mv -f dotfiles/gtk-3.0 ~/.config/gtk-3.0
mv -f dotfiles/gtk-2.0 ~/.config/gtk-2.0

# Step 7: Preparing LF.
echo "${b}- Preparing LF"
yay -S lf-git
sudo pacman -S --needed --noconfirm ueberzug ffmpegthumbnailer poppler imagemagick epub-thumbnailer bat unzip 7z unrar catdoc docx2txt odt2txt gnumeric iso-info
mv -f dotfiles/config/lf ~/.config/lf

# Step 8: Configuring X11.
echo "${b}- Configuring X11."
sudo pacman -S --needed --noconfirm xorg xorg-xinit
mv -f dotfiles/config/x11 ~/.config/x11

# Step 9: Configuring ZSH.
echo "${b}- Configuring ZSH."
sudo pacman -S --needed --noconfirm zsh
mv -f dotfiles/config/zsh ~/.config/zsh
ln -s ~/.config/zsh/profile ~/.zprofile
chsh -s /usr/bin/zsh

# Step 10: Configuring Neovim.
echo "${b}- Configuring Neovim."
sudo pacman -S --needed --noconfirm neovim
mv -f dotfiles/config/nvim/ ~/.config/nvim

# Step 11: Installing Tabbed.
echo "${b}- Installing Tabbed."
mv -f dotfiles/config/tabbed ~/.config/tabbed
sudo make install ~/.config/tabbed

# Step 12: Installing Dunst.
echo "${b}- Installing Dunst."
sudo pacman -S --needed --noconfirm dunst
mv -f dotfiles/config/dunst ~/.config/dunst

# Step 13: Configuring Neofetch.
echo "${b}- Configuring Neofetch."
sudo pacman -S --needed --noconfirm neofetch
mv -f dotfiles/config/neofetch ~/.config/neofetch

# Step 14: Configuring Slock.
echo "${b}- Configuring Slock."
mv -f dotfiles/config/slock ~/.config/slock
sudo make install ~/.config/slock

# Step 15: Installing SXIV.
echo "${b}- Installing SXIV."
sudo pacman -S --needed --noconfirm sxiv
mv -f dotfiles/config/sxiv ~/.config/sxiv

# Step 16: Misc Configuration.
echo "${b}- Configuring Extras."
mv -f dotfiles/config/mimeapps.list ~/.config/mimeapps.list
mv -f dotfiles/config/fontconfig ~/.config/fontconfig
mv -f dotfiles/bin/* ~/.local/bin/*

# Step 17: Delete ~/.cache/LARBS
echo "${b}- Deleting cache."
rm -rf ~/.cache/LARBS

# Notify the user that JARBS has finished
echo "${b}JARBS has finished installing! Have fun! :)" && exit
