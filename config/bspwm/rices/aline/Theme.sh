#!/usr/bin/env bash
#  ╔═╗╦  ╦╔╗╔╔═╗  ╦═╗╦╔═╗╔═╗
#  ╠═╣║  ║║║║║╣   ╠╦╝║║  ║╣ 	https://github.com/ghstzk/dotfiles
#  ╩ ╩╩═╝╩╝╚╝╚═╝  ╩╚═╩╚═╝╚═╝
## This file will configure the options
## and launch the bars corresponding to each theme.

# Set bspwm configuration for Aline
set_bspwm_config() {
		bspc config border_width 
		bspc config top_padding 57
		bspc config bottom_padding 2
		bspc config normal_border_color "#ca9ee6"
		bspc config active_border_color "#ca9ee6"
		bspc config focused_border_color "#8CAAEE"
		bspc config presel_feedback_color "#E78284"
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
				# Colors (Pencil light) Aline Rice
				colors:
				  primary:
				    background: '#e5eafe'
				    foreground: '#51576d'

				  normal:
				    black:   '#212121'
				    red:     '#c30771'
				    green:   '#10a778'
				    yellow:  '#a89c14'
				    blue:    '#008ec4'
				    magenta: '#523c79'
				    cyan:    '#20a5ba'
				    white:   '#51576d'

				  bright:
				    black:   '#212121'
				    red:     '#fb007a'
				    green:   '#5fd7af'
				    yellow:  '#f3e430'
				    blue:    '#20bbfc'
				    magenta: '#6855de'
				    cyan:    '#4fb8cc'
				    white:   '#51576d'

				  cursor:
				    cursor: '#20bbfc'
				    text:	'#e5eafe'
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
				*.foreground:     #51576d
				*.background:     #e5eafe

				! black
				*.color0:         #212121
				*.color8:         #212121

				! red
				*.color1:         #c30771
				*.color9:         #fb007a

				! green
				*.color2:         #10a778
				*.color10:        #5fd7af

				! yellow
				*.color3:         #a89c14
				*.color11:        #f3e430

				! blue
				*.color4:         #008ec4
				*.color12:        #20bbfc

				! magenta
				*.color5:         #523c79
				*.color13:        #6855de

				! cyan
				*.color6:         #20a5ba
				*.color14:        #4fb8cc

				! white
				*.color7:         #B5BFE2
				*.color15:        #A5ADCE
_EOF_
}

# Set compositor configuration
set_picom_config() {
		sed -i "$HOME"/.config/bspwm/picom.conf \
			-e "s/normal = .*/normal =  { fade = true; shadow = true; }/g" \
			-e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
			-e "s/corner-radius = .*/corner-radius = 6/g" \
			-e "s/\".*:class_g = 'Alacritty'\"/\"95:class_g = 'Alacritty'\"/g" \
			-e "s/\".*:class_g = 'FloaTerm'\"/\"95:class_g = 'FloaTerm'\"/g"

		sed -i '/EXTRA-RICE-CONF/Q' "$HOME"/.config/bspwm/picom.conf
		command cat >> "$HOME"/.config/bspwm/picom.conf <<- _EOF_
				#--EXTRA-RICE-CONF--#
_EOF_
}

# Set dunst notification daemon config
set_dunst_config() {
		sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 3/g" \
		-e "s/corner_radius = .*/corner_radius = 4/g" \
		-e "s/frame_color = .*/frame_color = \"#e5eafe\"/g" \
		-e "s/separator_color = .*/separator_color = \"#fb7a\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#2bbfc'/g"
		
		sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
		command cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
				[urgency_low]
				timeout = 3
				background = "#e5eafe"
				foreground = "#51576d"

				[urgency_normal]
				timeout = 6
				background = "#e5eafe"
				foreground = "#51576d"

				[urgency_critical]
				timeout = 
				background = "#e5eafe"
				foreground = "#51576d"
_EOF_
}

# Launch the bar
launch_bars() {
		polybar -q aline-bar -c ${rice_dir}/config.ini &
		if [[ ! -f "$LOCK_FILE" ]]; then
			sleep 0.2 && HideBar -h &
		fi
}


### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_xresources_config
set_picom_config
set_dunst_config
launch_bars
