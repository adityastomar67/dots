#!/usr/bin/env bash
#  ╦╔═╗╔═╗╔╗ ╔═╗╦    ╦═╗╦╔═╗╔═╗
#  ║╚═╗╠═╣╠╩╗║╣ ║    ╠╦╝║║  ║╣     https://github.com/gh0stzk/dotfiles
#  ╩╚═╝╩ ╩╚═╝╚═╝╩═╝  ╩╚═╩╚═╝╚═╝
## This file will configure the options
## and launch the bars corresponding to each theme.

# Set bspwm configuration for Isabel
set_bspwm_config() {
		bspc config border_width 0
		bspc config top_padding 2
		bspc config bottom_padding 42
		bspc config normal_border_color "#b8bfe5"
		bspc config active_border_color "#b8bfe5"
		bspc config focused_border_color "#7560d3"
		bspc config presel_feedback_color "#81ae5f"
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
				# Colors (Onedark) Isabel Rice
				colors:
				  primary:
				    background: '#14171c'
				    foreground: '#b8bfe5'

				  normal:
				    black:   '#5c6370'
				    red:     '#be5046'
				    green:   '#81ae5f'
				    yellow:  '#d19a66'
				    blue:    '#4889be'
				    magenta: '#7560d3'
				    cyan:    '#49919a'
				    white:   '#c5cddb'

				  bright:
				    black:   '#5c6370'
				    red:     '#e06c75'
				    green:   '#98c379'
				    yellow:  '#e5c07b'
				    blue:    '#61afef'
				    magenta: '#8677cf'
				    cyan:    '#56b6c2'
				    white:   '#abb2bf'

				  cursor:
				    cursor: '#abb2bf'
				    text:	'#14171c'
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
				*.foreground:     #b8bfe5
				*.background:     #14171c

				! black
				*.color0:         #5c6370
				*.color8:         #5c6370

				! red
				*.color1:         #be5046
				*.color9:         #e06c75

				! green
				*.color2:         #81ae5f
				*.color10:        #98c379

				! yellow
				*.color3:         #d19a66
				*.color11:        #e5c07b

				! blue
				*.color4:         #4889be
				*.color12:        #61afef

				! magenta
				*.color5:         #7560d3
				*.color13:        #8677cf

				! cyan
				*.color6:         #49919a
				*.color14:        #56b6c2

				! white
				*.color7:         #c5cddb
				*.color15:        #abb2bf
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
		-e "s/frame_color = .*/frame_color = \"#14171c\"/g" \
		-e "s/separator_color = .*/separator_color = \"#abb2bf\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#7560d3'/g"
		
		sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
		command cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
				[urgency_low]
				timeout = 3
				background = "#14171c"
				foreground = "#b8bfe5"

				[urgency_normal]
				timeout = 6
				background = "#14171c"
				foreground = "#b8bfe5"

				[urgency_critical]
				timeout = 0
				background = "#14171c"
				foreground = "#b8bfe5"
_EOF_
}

# Launch the bar
launch_bars() {
		polybar -q isa-bar -c ${rice_dir}/config.ini &
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
