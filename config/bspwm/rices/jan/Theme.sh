#!/usr/bin/env bash
#   ╦╔═╗╔╗╔  ╦═╗╦╔═╗╔═╗
#   ║╠═╣║║║  ╠╦╝║║  ║╣ 	https://github.com/gh0stzk/dotfiles
#  ╚╝╩ ╩╝╚╝  ╩╚═╩╚═╝╚═╝
## This file will configure the options
## and launch the bars corresponding to each theme.

# Set bspwm configuration for Jan
set_bspwm_config() {
		bspc config border_width 0
		bspc config top_padding 64
		bspc config bottom_padding 2
		bspc config normal_border_color "#4C3A6D"
		bspc config active_border_color "#4C3A6D"
		bspc config focused_border_color "#785DA5"
		bspc config presel_feedback_color "#070219"
		bspc config left_padding 2
		bspc config right_padding 2
		bspc config window_gap 6
}

# Reload terminal colors
set_term_config() {
		sed -i "$HOME"/.config/alacritty/fonts.yml \
		-e "s/family: .*/family: JetBrainsMono Nerd Font/g" \
		-e "s/size: .*/size: 10/g"
		
		command cat > "$HOME"/.config/alacritty/colors.yml <<- _EOF_
				# Colors (CyberPunk) Jan Rice
				colors:
				  primary:
				    background: '#070219'
				    foreground: '#c0caf5'

				  normal:
				    black:   '#626483'
				    red:     '#fb007a'
				    green:   '#a6e22e'
				    yellow:  '#f3e430'
				    blue:    '#58AFC2'
				    magenta: '#583794'
				    cyan:    '#926BCA'
				    white:   '#d9d9d9'

				  bright:
				    black:   '#626483'
				    red:     '#fb007a'
				    green:   '#a6e22e'
				    yellow:  '#f3e430'
				    blue:    '#58AFC2'
				    magenta: '#472575'
				    cyan:    '#926BCA'
				    white:   '#f1f1f1'
   
				  cursor:
				    cursor: '#fb007a'
				    text:	'#070219'
_EOF_
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
				*.foreground:     #c0caf5
				*.background:     #070219

				! black
				*.color0:         #626483
				*.color8:         #626483

				! red
				*.color1:         #fb007a
				*.color9:         #fb007a

				! green
				*.color2:         #a6e22e
				*.color10:        #a6e22e

				! yellow
				*.color3:         #f3e430
				*.color11:        #f3e430

				! blue
				*.color4:         #58AFC2
				*.color12:        #58AFC2

				! magenta
				*.color5:         #583794
				*.color13:        #472575

				! cyan
				*.color6:         #926BCA
				*.color14:        #926BCA

				! white
				*.color7:         #d9d9d9
				*.color15:        #f1f1f1
_EOF_
}

# Set compositor configuration
set_picom_config() {
		sed -i "$HOME"/.config/bspwm/picom.conf \
			-e "s/normal = .*/normal =  { fade = true; shadow = false; }/g" \
			-e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
			-e "s/corner-radius = .*/corner-radius = 0/g" \
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
		-e "s/transparency = .*/transparency = 8/g" \
		-e "s/corner_radius = .*/corner_radius = 4/g" \
		-e "s/frame_color = .*/frame_color = \"#070219\"/g" \
		-e "s/separator_color = .*/separator_color = \"#fb007a\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#f9f9f9'/g"
		
		sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
		command cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
				[urgency_low]
				timeout = 3
				background = "#070219"
				foreground = "#c0caf5"

				[urgency_normal]
				timeout = 6
				background = "#070219"
				foreground = "#c0caf5"

				[urgency_critical]
				timeout = 0
				background = "#070219"
				foreground = "#c0caf5"
_EOF_
}

# Launch the bar
launch_bars() {
		polybar -q main -c ${rice_dir}/config.ini &
		if [[ -f "$LOCK_FILE" ]]; then
			sleep 1 && HideBar -h &
		fi
}


### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_xresources_config
set_picom_config
set_dunst_config
launch_bars
