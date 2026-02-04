#!/usr/bin/env bash
set -e

DOTFILES="$HOME/dotfiles"

echo "Linking dotfiles..."

mkdir -p ~/.config

ln -snf "$DOTFILES/nvim" ~/.config/nvim
ln -snf "$DOTFILES/wezterm/wezterm.lua" ~/.wezterm.lua

echo "Done!"
