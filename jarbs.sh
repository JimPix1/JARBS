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
su -c "pacman -Sy --needed --noconfirm git"
echo "${b}- Cloning the dotfiles."
git clone https://github.com/JimPix1/dotfiles/

# Step 1: DWM Installation
echo "${b}- Installing DWM."
git clone https://aur.archlinux.org/libxft-bgra.git
cd libxft-bgra || exit
makepkg -si --noconfirm
cd ..
mkdir -p ~/.config
mv -f dotfiles/config/dwm ~/.config/dwm
su -c "make install ~/.config/dwm"

# Step 2: St Installation
echo "${b}- Installing st (suckless terminal)."
mv -f dotfiles/config/st ~/.config/st
su -c "make install ~/.config/st"

# Step 3: Dwmblocks Installation
echo "${b}- Installing Dwmblocks."
mv -f dotfiles/config/dwmblocks ~/.config/dwmblocks
su -c "make install ~/.config/dwmblocks"

# Step 4: Dmenu Installation
echo "${b}- Installing Dmenu."
mv -f dotfiles/config/dmenu ~/.config/dmenu
su -c "make install ~/.config/dmenu"

# Step 5: Picom Installation
echo "${b}- Installing Picom."
su -c "pacman -S --needed --noconfirm picom"
mv -f dotfiles/config/picom ~/.config/picom

# Step 6: Theming
echo "${b}- Configuring Theming."
su -c "pacman -S --needed --noconfirm materia-gtk-theme"
su -c "pacman -S --needed --noconfirm papirus-icon-theme"
mv -f dotfiles/gtk-3.0 ~/.config/gtk-3.0
mv -f dotfiles/gtk-2.0 ~/.config/gtk-2.0

# Step 7: Preparing LF.
echo "${b}- Preparing LF"
git clone https://aur.archlinux.org/lf.git
cd lf || exit
makepkg -si --noconfirm
cd ..
su -c "pacman -S --needed --noconfirm ueberzug"
mv -f dotfiles/config/lf ~/.config/lf

# Step 8: Configuring X11.
echo "${b}- Configuring X11."
su -c "pacman -S --needed --noconfirm xorg xorg-xinit"
mv -f dotfiles/config/x11 ~/.config/x11

# Step 9: Configuring ZSH.
echo "${b}- Configuring ZSH."
su -c "pacman -S --needed --noconfirm zsh"
chsh -s /usr/bin/zsh
mv -f dotfiles/config/zsh ~/.config/zsh

# Step 10: Configuring Neovim.
echo "${b}- Configuring Neovim."
su -c "pacman -S --needed --noconfirm neovim"
mv -f dotfiles/config/nvim/ ~/.config/nvim

# Step 11: Installing Tabbed.
echo "${b}- Installing Tabbed."
mv -f dotfiles/config/tabbed ~/.config/tabbed
su -c "make install ~/.config/tabbed"

# Step 12: Installing Dunst.
echo "${b}- Installing Dunst."
su -c "pacman -S --needed --noconfirm dunst"
mv -f dotfiles/config/dunst ~/.config/dunst

# Step 13: Configuring Neofetch.
echo "${b}- Configuring Neofetch."
su -c "pacman -S --needed --noconfirm neofetch"
mv -f dotfiles/config/neofetch ~/.config/neofetch

# Step 14: Configuring Slock.
echo "${b}- Configuring Slock."
mv -f dotfiles/config/slock ~/.config/slock
su -c "make install ~/.config/slock"

# Step 15: Installing SXIV.
echo "${b}- Installing SXIV."
su -c "pacman -S --needed --noconfirm sxiv"
mv -f dotfiles/config/sxiv ~/.config/sxiv

# Step 16: Misc Configuration.
echo "${b}- Configuring Extras."
mv -f dotfiles/config/mimeapps.list ~/.config/
mv -f dotfiles/bin ~/.local/

# Step 17: Delete ~/.cache/LARBS
echo "${b}- Deleting cache."
rm -rf ~/.cache/LARBS

# Notify the user that JARBS has finished
echo "${b}JARBS has finished installing! Have fun! :)" && exit
