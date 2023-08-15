#!/usr/bin/env bash
#  ╔═╗╔╗╔╔╦╗╦═╗╔═╗╔═╗  ╦═╗╦╔═╗╔═╗
#  ╠═╣║║║ ║║╠╦╝║╣ ╠═╣  ╠╦╝║║  ║╣ 	https://github.com/gh0stzk/dotfiles
#  ╩ ╩╝╚╝═╩╝╩╚═╚═╝╩ ╩  ╩╚═╩╚═╝╚═╝
## This file will configure the options
## and launch the bars corresponding to each theme.

# Set bspwm configuration for Andrea
set_bspwm_config() {
		bspc config border_width 0
		bspc config top_padding 67
		bspc config bottom_padding 2
		bspc config normal_border_color "#161616"
		bspc config active_border_color "#161616"
		bspc config focused_border_color "#605692"
		bspc config presel_feedback_color "#67d4f1"
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
		-e "s/colors: .*/colors: *andrea_color_scheme/"
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
				*.foreground:     #6d6a78
				*.background:     #F5EEE6

				! black
				*.color0:         #80859d
				*.color8:         #80859d

				! red
				*.color1:         #c04364
				*.color9:         #c03f61

				! green
				*.color2:         #abd77a
				*.color10:        #a1d16c

				! yellow
				*.color3:         #ffcc57
				*.color11:        #f2be47

				! blue
				*.color4:         #67d4f1
				*.color12:        #50bfdc

				! magenta
				*.color5:         #7a7498
				*.color13:        #605692

				! cyan
				*.color6:         #9bf4d5
				*.color14:        #83edc8

				! white
				*.color7:         #b0b0b0
				*.color15:        #b0b0b0
_EOF_
}

# Set compositor configuration
set_picom_config() {
		sed -i "$HOME"/.config/bspwm/picom.conf \
			-e "s/normal = .*/normal =  { fade = true; shadow = true; }/g" \
			-e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
			-e "s/corner-radius = .*/corner-radius = 6/g" \
			-e "s/\".*:class_g = 'Alacritty'\"/\"96:class_g = 'Alacritty'\"/g" \
			-e "s/\".*:class_g = 'FloaTerm'\"/\"96:class_g = 'FloaTerm'\"/g"

		sed -i '/EXTRA-RICE-CONF/Q' "$HOME"/.config/bspwm/picom.conf
		command cat >> "$HOME"/.config/bspwm/picom.conf <<- _EOF_
				#--EXTRA-RICE-CONF--#
_EOF_
}

# Set dunst notification daemon config
set_dunst_config() {
		sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 1/g" \
		-e "s/corner_radius = .*/corner_radius = 4/g" \
		-e "s/frame_color = .*/frame_color = \"#F5EEE6\"/g" \
		-e "s/separator_color = .*/separator_color = \"#605692\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#605692'/g"
		
		sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
		command cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
				[urgency_low]
				timeout = 3
				background = "#F5EEE6"
				foreground = "#161616"

				[urgency_normal]
				timeout = 6
				background = "#F5EEE6"
				foreground = "#161616"

				[urgency_critical]
				timeout = 0
				background = "#F5EEE6"
				foreground = "#161616"
_EOF_
}

# Launch the bar
launch_bars() {
		eww -c ${rice_dir}/arin open-many search apps weather music system &
}


### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_xresources_config
set_picom_config
set_dunst_config
launch_bars
