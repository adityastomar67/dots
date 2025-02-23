#!/usr/bin/env bash
#  ╔═╗╔═╗╔╦╗╔═╗╦  ╔═╗  ╦═╗╦╔═╗╔═╗
#  ╠═╝╠═╣║║║║╣ ║  ╠═╣  ╠╦╝║║  ║╣	https://github.com/gh0stzk/dotfiles 
#  ╩  ╩ ╩╩ ╩╚═╝╩═╝╩ ╩  ╩╚═╩╚═╝╚═╝
## This file will configure the options
## and launch the bars corresponding to each theme.

# Set bspwm configuration for Pamela
set_bspwm_config() {
		bspc config border_width 0
		bspc config top_padding 59
		bspc config bottom_padding 2
		bspc config normal_border_color "#C574DD"
		bspc config active_border_color "#C574DD"
		bspc config focused_border_color "#8897F4"
		bspc config presel_feedback_color "#FF4971"
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
		-e "s/colors: .*/colors: *pamela_color_scheme/"
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
				*.foreground:     #FDFDFD
				*.background:     #1D1F28

				! black
				*.color0:         #3D4C5F
				*.color8:         #56687E

				! red
				*.color1:         #F37F97
				*.color9:         #FF4971

				! green
				*.color2:         #5ADECD
				*.color10:        #18E3C8

				! yellow
				*.color3:         #F2A272
				*.color11:        #FF8037

				! blue
				*.color4:         #8897F4
				*.color12:        #556FFF

				! magenta
				*.color5:         #C574DD
				*.color13:        #B043D1

				! cyan
				*.color6:         #79E6F3
				*.color14:        #3FDCEE

				! white
				*.color7:         #FDFDFD
				*.color15:        #BEBEC1
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
		-e "s/transparency = .*/transparency = 9/g" \
		-e "s/corner_radius = .*/corner_radius = 4/g" \
		-e "s/frame_color = .*/frame_color = \"#1D1F28\"/g" \
		-e "s/separator_color = .*/separator_color = \"#8897F4\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#79E6F3'/g"
		
		sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
		command cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
				[urgency_low]
				timeout = 3
				background = "#1D1F28"
				foreground = "#FDFDFD"

				[urgency_normal]
				timeout = 6
				background = "#1D1F28"
				foreground = "#FDFDFD"

				[urgency_critical]
				timeout = 0
				background = "#1D1F28"
				foreground = "#FDFDFD"
_EOF_
}

# Launch the bar
launch_bars() {
		eww -c ${rice_dir}/widgets daemon &
		polybar -q pam1 -c ${rice_dir}/config.ini &
		polybar -q pam2 -c ${rice_dir}/config.ini &
		polybar -q pam3 -c ${rice_dir}/config.ini &
		polybar -q pam4 -c ${rice_dir}/config.ini &
		polybar -q pam5 -c ${rice_dir}/config.ini &
		polybar -q pam6 -c ${rice_dir}/config.ini &
}


### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_xresources_config
set_picom_config
set_dunst_config
launch_bars
