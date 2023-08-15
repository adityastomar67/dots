#!/usr/bin/env bash
#  ╔═╗╦═╗╦╔═╗╔╦╗╦╔╗╔╔═╗  ╦═╗╦╔═╗╔═╗
#  ║  ╠╦╝║╚═╗ ║ ║║║║╠═╣  ╠╦╝║║  ║╣ 	https://github.com/gh0stzk/dotfiles
#  ╚═╝╩╚═╩╚═╝ ╩ ╩╝╚╝╩ ╩  ╩╚═╩╚═╝╚═╝
## This file will configure the options
## and launch the bars corresponding to each theme.

# Set bspwm configuration for Cristina
set_bspwm_config() {
		bspc config border_width 0
		bspc config top_padding 2
		bspc config bottom_padding 60
		bspc config normal_border_color "#9bced7"
		bspc config active_border_color "#9bced7"
		bspc config focused_border_color "#c3a5e6"
		bspc config presel_feedback_color "#c3a5e6"
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
		-e "s/colors: .*/colors: *cristina_rose_pine/"
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
				*.foreground:     #eaeaea
				*.background:     #1f1d29

				! black
				*.color0:         #6f6e85
				*.color8:         #6f6e85

				! red
				*.color1:         #ea6f91
				*.color9:         #ea6f91

				! green
				*.color2:         #9bced7
				*.color10:        #9bced7

				! yellow
				*.color3:         #f1ca93
				*.color11:        #f1ca93

				! blue
				*.color4:         #34738e
				*.color12:        #34738e

				! magenta
				*.color5:         #c3a5e6
				*.color13:        #c3a5e6

				! cyan
				*.color6:         #eabbb9
				*.color14:        #ebbcba

				! white
				*.color7:         #faebd7
				*.color15:        #e0def4
_EOF_
}

# Set compositor configuration
set_picom_config() {
		sed -i "$HOME"/.config/bspwm/picom.conf \
			-e "s/normal = .*/normal =  { fade = true; shadow = true; }/g" \
			-e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
			-e "s/corner-radius = .*/corner-radius = 6/g" \
			-e "s/\".*:class_g = 'Alacritty'\"/\"100:class_g = 'Alacritty'\"/g" \
			-e "s/\".*:class_g = 'FloaTerm'\"/\"100:class_g = 'FloaTerm'\"/g"

		sed -i '/EXTRA-RICE-CONF/Q' "$HOME"/.config/bspwm/picom.conf
		command cat >> "$HOME"/.config/bspwm/picom.conf <<- _EOF_
				#--EXTRA-RICE-CONF--#
_EOF_
}

# Set dunst notification daemon config
set_dunst_config() {
		sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 0/g" \
		-e "s/corner_radius = .*/corner_radius = 4/g" \
		-e "s/frame_color = .*/frame_color = \"#1f1d29\"/g" \
		-e "s/separator_color = .*/separator_color = \"#ea6f91\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#9bced7'/g"
		
		sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
		command cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
				[urgency_low]
				timeout = 3
				background = "#1f1d29"
				foreground = "#eaeaea"

				[urgency_normal]
				timeout = 6
				background = "#1f1d29"
				foreground = "#eaeaea"

				[urgency_critical]
				timeout = 0
				background = "#1f1d29"
				foreground = "#eaeaea"
_EOF_
}

# Launch the bar and or eww widgets
launch_bars() {
		# eww -c ${rice_dir}/widgets daemon &
		polybar -q cristina-bar -c ${rice_dir}/config.ini &
}


### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_xresources_config
set_picom_config
set_dunst_config
launch_bars
