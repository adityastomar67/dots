#!/usr/bin/env bash
#  ╦╔═╔═╗╦═╗╦  ╔═╗  ╦═╗╦╔═╗╔═╗
#  ╠╩╗╠═╣╠╦╝║  ╠═╣  ╠╦╝║║  ║╣ 	https://github.com/gh0stzk/dotfiles
#  ╩ ╩╩ ╩╩╚═╩═╝╩ ╩  ╩╚═╩╚═╝╚═╝
## This file will configure the options
## and launch the bars corresponding to each theme.

# Set bspwm configuration for Karla
set_bspwm_config() {
		bspc config border_width 0
		bspc config top_padding 64
		bspc config bottom_padding 2
		bspc config normal_border_color "#ff004a"
		bspc config active_border_color "#ff004a"
		bspc config focused_border_color "#0864f1"
		bspc config presel_feedback_color "#b93fe0"
		bspc config left_padding 2
		bspc config right_padding 2
		bspc config window_gap 6
}

# Reload terminal colors
set_term_config() {
		sed -i "$HOME"/.config/alacritty/fonts.yml \
		-e "s/family: .*/family: JetBrainsMono Nerd Font/g" \
		-e "s/size: .*/size: 10/g"
		
		sed -i "$HOME"/.config/alacritty/rice-colors.yml \
		-e "s/colors: .*/colors: *karla_sunflower_day/"
}

# Reload xresources colors
set_xresources_config() {
		command cat > "$HOME"/.config/bspwm/xresources <<- _EOF_
				Xft.antialias:	  1
				Xft.hinting:	  1
				Xft.autohint:	  0
				Xft.hintstyle:	  hintslight
				Xft.rgba:	      rgb
				Xft.lcdfilter:	  lcddefault

				! font
				st.font:          Operator Mono Lig:style:medium:pixelsize=18
				dmenu.font:       Operator Mono Lig:style:medium:pixelsize=18

				! window-padding
				st.borderpx:      20

				! transparency
				st.alpha:         0.9

				! special
				*.foreground:     #2d2e33
				*.background:     #e1eaff

				! black
				*.color0:         #020816
				*.color8:         #7d829e

				! red
				*.color1:         #ff004a
				*.color9:         #e74f62

				! green
				*.color2:         #1bce5f
				*.color10:        #57e28a

				! yellow
				*.color3:         #ffcb00
				*.color11:        #fcde68

				! blue
				*.color4:         #0864f1
				*.color12:        #3d7fea

				! magenta
				*.color5:         #b93fe0
				*.color13:        #da80f4

				! cyan
				*.color6:         #17bcef
				*.color14:        #74cbe7

				! white
				*.color7:         #9da6ba
				*.color15:        #7d829e
_EOF_
}

# Set compositor configuration
set_picom_config() {
		sed -i "$HOME"/.config/bspwm/picom.conf \
			-e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
			-e "s/corner-radius = .*/corner-radius = 6/g" \
			-e "s/\".*:class_g = 'Alacritty'\"/\"95:class_g = 'Alacritty'\"/g" \
			-e "s/\".*:class_g = 'FloaTerm'\"/\"95:class_g = 'FloaTerm'\"/g" \
			-e "s/\".*:class_g = 'Updating'\"/\"95:class_g = 'Updating'\"/g" \
			-e "s/\".*:class_g = 'MusicPlayer'\"/\"95:class_g = 'MusicPlayer'\"/g" \
			-e "s/\".*:class_g = 'Sysfetch'\"/\"95:class_g = 'Sysfetch'\"/g" \
			-e "s/\".*:class_g = 'scratch'\"/\"90:class_g = 'scratch'\"/g"

		sed -i '/EXTRA-RICE-CONF/Q' "$HOME"/.config/bspwm/picom.conf
		command cat >> "$HOME"/.config/bspwm/picom.conf <<- _EOF_
				#--EXTRA-RICE-CONF--#
_EOF_
}

# Set dunst notification daemon config
set_dunst_config() {
		sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 4/g" \
		-e "s/corner_radius = .*/corner_radius = 4/g" \
		-e "s/frame_color = .*/frame_color = \"#e1eaff\"/g" \
		-e "s/separator_color = .*/separator_color = \"#2d2e33\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#3d7fea'/g"
		
		sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
		command cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
				[urgency_low]
				timeout = 3
				background = "#e1eaff"
				foreground = "#151515"

				[urgency_normal]
				timeout = 6
				background = "#e1eaff"
				foreground = "#151515"

				[urgency_critical]
				timeout = 0
				background = "#e1eaff"
				foreground = "#151515"
_EOF_
}

# Launch the bar
launch_bars() {
		eww -c ${rice_dir}/bar open bar &
		polybar -q karla-bar -c ${rice_dir}/config.ini &
		polybar -q karla-bar2 -c ${rice_dir}/config.ini &
}

### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_xresources_config
set_picom_config
set_dunst_config
launch_bars
