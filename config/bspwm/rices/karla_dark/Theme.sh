#!/usr/bin/env bash
#  ╦╔═╔═╗╦═╗╦  ╔═╗  ╦═╗╦╔═╗╔═╗
#  ╠╩╗╠═╣╠╦╝║  ╠═╣  ╠╦╝║║  ║╣ 	https://github.com/gh0stzk/dotfiles
#  ╩ ╩╩ ╩╩╚═╩═╝╩ ╩  ╩╚═╩╚═╝╚═╝
## This file will configure the options
## and launch the bars corresponding to each theme.

# Set bspwm configuration for Karla
set_bspwm_config() {
		bspc config border_width 3
		bspc config top_padding 48
		bspc config bottom_padding 2
		bspc config normal_border_color "#21222c"
		bspc config active_border_color "#353c52"
		bspc config focused_border_color "#353c52"
		bspc config presel_feedback_color "#ff79c6"
		bspc config left_padding 2
		bspc config right_padding 2
		bspc config window_gap 6
}

# Reload terminal colors
set_term_config() {
		sed -i "$HOME"/.config/alacritty/fonts.yml \
		-e "s/family: .*/family: JetBrainsMono Nerd Font/g" \
		-e "s/size: .*/size: 10/g"
		
		cat > "$HOME"/.config/alacritty/colors.yml <<- _EOF_
				# Colors (Zombie-Night color scheme) Karla Rice
				colors:
				  primary:
				    background: '#0E1113'
				    foreground: '#afb1db'

				  normal:
				    black:   '#2d2b36'
				    red:     '#e7034a'
				    green:   '#61b33e'
				    yellow:  '#ffb964'
				    blue:    '#5884d4'
				    magenta: '#7a44e3'
				    cyan:    '#7df0f0'
				    white:   '#faf7ff'

				  bright:
				    black:   '#373542'
				    red:     '#e71c5b'
				    green:   '#6fb352'
				    yellow:  '#ffb964'
				    blue:    '#5f90ea'
				    magenta: '#8656e3'
				    cyan:    '#97f0f0'
				    white:   '#fdfcff'
    
				  cursor:
				     cursor: '#8656e3'
				     text:	'#0b0b12'
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
				*.foreground:     #afb1db
				*.background:     #0E1113

				! black
				*.color0:         #2d2b36
				*.color8:         #373542

				! red
				*.color1:         #e7034a
				*.color9:         #e71c5b

				! green
				*.color2:         #61b33e
				*.color10:        #6fb352

				! yellow
				*.color3:         #ffb964
				*.color11:        #ffb964

				! blue
				*.color4:         #5884d4
				*.color12:        #5f90ea

				! magenta
				*.color5:         #7a44e3
				*.color13:        #8656e3

				! cyan
				*.color6:         #7df0f0
				*.color14:        #97f0f0

				! white
				*.color7:         #faf7ff
				*.color15:        #fdfcff
_EOF_
}

# Set compositor configuration
set_picom_config() {
		sed -i "$HOME"/.config/bspwm/picom.conf \
			-e "s/normal = .*/normal =  { fade = false; shadow = false; }/g" \
			-e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
			-e "s/corner-radius = .*/corner-radius = 0/g" \
			-e "s/\".*:class_g = 'Alacritty'\"/\"95:class_g = 'Alacritty'\"/g" \
			-e "s/\".*:class_g = 'FloaTerm'\"/\"95:class_g = 'FloaTerm'\"/g"
}

# Set dunst notification daemon config
set_dunst_config() {
		sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 8/g" \
		-e "s/frame_color = .*/frame_color = \"#0E1113\"/g" \
		-e "s/separator_color = .*/separator_color = \"#353c52\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#7a44e3'/g"
		
		sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
		cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
				[urgency_low]
				timeout = 3
				background = "#0E1113"
				foreground = "#afb1db"

				[urgency_normal]
				timeout = 6
				background = "#0E1113"
				foreground = "#afb1db"

				[urgency_critical]
				timeout = 0
				background = "#0E1113"
				foreground = "#afb1db"
_EOF_
}

# Launch the bar
launch_bars() {
		polybar -q karla-dark-bar -c ${rice_dir}/config.ini &
		polybar -q karla-dark-bar2 -c ${rice_dir}/config.ini &
		polybar -q karla-dark-bar3 -c ${rice_dir}/config.ini &
}

### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_picom_config
set_dunst_config
set_xresources_config
launch_bars
