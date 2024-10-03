#!/usr/bin/env sh

gnome_schema="org.gnome.desktop.interface"
cursor_theme="catppuccin-mocha-dark-cursors"
cursor_size="24"
theme_name="Adwaita-dark"
font_name="Ubuntu Mono"

hyprctl setcursor "$cursor_theme" "$cursor_size"

gsettings set "$gnome_schema" cursor-theme "$cursor_theme"
gsettings set "$gnome_schema" cursor-size "$cursor_size"
gsettings set "$gnome_schema" font-name "$font_name"
gsettings set "$gnome_schema" color-scheme "prefer-dark"
gsettings set "$gnome_schema" gtk-theme "$theme_name"