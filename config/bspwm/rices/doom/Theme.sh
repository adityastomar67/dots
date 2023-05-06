#!/usr/bin/env bash
#  ╔═╗╔╦╗╦╦  ╦╔═╗  ╦═╗╦╔═╗╔═╗
#  ║╣ ║║║║║  ║╠═╣  ╠╦╝║║  ║╣ 	https://github.com/gh0stzk/dotfiles
#  ╚═╝╩ ╩╩╩═╝╩╩ ╩  ╩╚═╩╚═╝╚═╝
## This file will configure the options
## and launch the bars corresponding to each theme.

# Set bspwm configuration for Emilia
set_bspwm_config() {
		bspc config top_padding 59
		bspc config bottom_padding 2
		bspc config active_border_color "#ebdbb2"
		bspc config presel_feedback_color "#83a597"
		bspc config left_padding 2
		bspc config right_padding 2
		bspc config window_gap 6
		bspc monitor -d TERM CODE WEB MISC EDIT CHAT DISCORD MUSIC
		bspc config border_width 2
		bspc config focused_border_color "#928374"
		bspc config normal_border_color "#282828"
		bspc config window_gap 6
		bspc config borderless_monocle true
		bspc config gapless_monocle true
		bspc config single_monocle false
}

# Reload terminal colors
set_term_config() {
		sed -i "$HOME"/.config/alacritty/fonts.yml \
		-e "s/family: .*/family: JetBrainsMono Nerd Font/g" \
		-e "s/size: .*/size: 10/g"
		
		command cat > "$HOME"/.config/alacritty/colors.yml <<- _EOF_
				# Colors (Tokyo Night) Emilia Rice
				colors:
				  primary:
				    background: '#1D2021'
				    foreground: '#fbf1c7'

				  normal:
				    black:   '#1D2021'
				    red:     '#fb4833'
				    green:   '#b8ba25'
				    yellow:  '#fabc2e'
				    blue:    '#83a597'
				    magenta: '#d3859a'
				    cyan:    '#FE8019'
				    white:   '#a89983'

				  bright:
				    black:   '#1D2021'
				    red:     '#fb4833'
				    green:   '#b8ba25'
				    yellow:  '#fabc2e'
				    blue:    '#83a597'
				    magenta: '#d3859a'
				    cyan:    '#FE8019'
				    white:   '#ebdbb2'

				  cursor:
				    cursor: '#d3859a'
				    text:	'#1a1b26'
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
				*.foreground:     #fbf1c7
				*.background:     #1D2021

				! black
				*.color0:         #1D2021
				*.color8:         #928373

				! red
				*.color1:         #fb4833
				*.color9:         #fb4833

				! green
				*.color2:         #b8ba25
				*.color10:        #b8ba25

				! yellow
				*.color3:         #fabc2e
				*.color11:        #fabc2e

				! blue
				*.color4:         #83a597
				*.color12:        #83a597

				! magenta
				*.color5:         #d3859a
				*.color13:        #d3859a

				! cyan
				*.color6:         #FE8019
				*.color14:        #FE8019

				! white
				*.color7:         #a89983
				*.color15:        #ebdbb2
_EOF_
}

# Set compositor configuration
set_picom_config() {
		sed -i "$HOME"/.config/bspwm/picom.conf \
			-e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
			-e "s/corner-radius = .*/corner-radius = 0/g" \
			-e "s/\".*:class_g = 'Alacritty'\"/\"100:class_g = 'Alacritty'\"/g" \
			-e "s/\".*:class_g = 'FloaTerm'\"/\"100:class_g = 'FloaTerm'\"/g" \
			-e "s/\".*:class_g = 'Updating'\"/\"100:class_g = 'Updating'\"/g" \
			-e "s/\".*:class_g = 'MusicPlayer'\"/\"100:class_g = 'MusicPlayer'\"/g" \
			-e "s/\".*:class_g = 'Sysfetch'\"/\"100:class_g = 'Sysfetch'\"/g" \
			-e "s/\".*:class_g = 'scratch'\"/\"90:class_g = 'scratch'\"/g"

		sed -i '/EXTRA-RICE-CONF/Q' "$HOME"/.config/bspwm/picom.conf
		command cat >> "$HOME"/.config/bspwm/picom.conf <<- _EOF_
				#--EXTRA-RICE-CONF--#
				
				shadow = true;
				no-dnd-shadow = true;
				no-dock-shadow = true;
				clear-shadow = true;
				shadow-exclude = [
					"class_g ='polybar'",
					"class_g = 'tray'",
					"class_g = 'Polybar'"
				]

				fade-delta = 0.25;
				fade-in-step = 0.02;
				fade-out-step = 0.02;

				refresh-rate = 0;
				dbe = false;
				paint-on-overlay = true;
				
				focus-exclude = [ 
					"class_g = 'Cairo-clock'" ,
					"class_g = 'CoverGloobus'",
					"class_g = 'Tilda'",
					"class_g = 'firefox'",
					"class_g = 'Firefox-esr'"
				];
				detect-client-leader = true;
				invert-color-include = [ ];
				glx-copy-from-front = false;
				wintypes:
				{
				tooltip = { fade = true; shadow = true; opacity = 0.75; focus = true; };
				};
_EOF_
}

# Set dunst notification daemon config
set_dunst_config() {
		sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 0/g" \
		-e "s/corner_radius = .*/corner_radius = 0/g" \
		-e "s/frame_color = .*/frame_color = \"#1D2021\"/g" \
		-e "s/separator_color = .*/separator_color = \"#32302f\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#b8bb26'/g"
		
		sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
		command cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
				[urgency_low]
				timeout = 3
				background = "#1D2021"
				foreground = "#ebdbb2"

				[urgency_normal]
				timeout = 6
				background = "#1D2021"
				foreground = "#ebdbb2"

				[urgency_critical]
				timeout = 0
				background = "#1D2021"
				foreground = "#ebdbb2"
_EOF_
}

# Launch the bar
launch_bars() {
		polybar -q doom-bar -c ${rice_dir}/config.ini &
}


### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_xresources_config
set_picom_config
set_dunst_config
launch_bars
