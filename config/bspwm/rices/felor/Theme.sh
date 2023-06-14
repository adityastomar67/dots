#!/usr/bin/env bash
#  ╔═╗╔╦╗╦╦  ╦╔═╗  ╦═╗╦╔═╗╔═╗
#  ║╣ ║║║║║  ║╠═╣  ╠╦╝║║  ║╣ 	https://github.com/gh0stzk/dotfiles
#  ╚═╝╩ ╩╩╩═╝╩╩ ╩  ╩╚═╩╚═╝╚═╝
## This file will configure the options
## and launch the bars corresponding to each theme.

# Set bspwm configuration for Emilia
set_bspwm_config() {
	    bspc config border_radius 0
		bspc config border_width 2
		bspc config window_gap 10
		bspc config borderless_monocle false
		bspc config gapless_monocle false
		bspc config top_padding 57
		bspc config bottom_padding 2
		bspc config left_padding 2
		bspc config right_padding 2
		bspc monitor -d   "" "" "" "" "" "嗢" "" "" "" 

		bspc config normal_border_color "$background"
		bspc config focused_border_color "$background"
		bspc config presel_feedback_color "$color4"

		conky -c ${rice_dir}/conky/ConkyWidgets/conky-widgets &
		nm-applet &
		blueman-applet &
		kdeconnect-indicator &
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
				*.foreground:     gray90
				*.background:     black

				! black
				*.color0:         black
				*.color8:         gray50

				! red
				*.color1:         red3
				*.color9:         red

				! green
				*.color2:         green3
				*.color10:        green

				! yellow
				*.color3:         yellow3
				*.color11:        yellow

				! blue
				*.color4:         blue2
				*.color12:        #5c5cff

				! magenta
				*.color5:         magenta3
				*.color13:        magenta

				! cyan
				*.color6:         cyan3
				*.color14:        cyan

				! white
				*.color7:         gray90
				*.color15:        white
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
				shadow-opacity = 0.4;
				shadow-offset-x = -11;
				shadow-offset-y = -11;

				shadow-exclude = [
					"class_g *= 'Polybar'",
				"_GTK_FRAME_EXTENTS@:c"
				];

				frame-opacity = 1.0
				inactive-opacity-override = false;

				focus-exclude = [ "class_g = 'Cairo-clock'" ];

				opacity-rule = [ 
					"100:class_g = 'URxvt'",
					"100:class_g *= 'Polybar'",
					"100:class_g *= 'St'",
					"100:class_g *= 'Zathura'",
					"100:class_g = 'awesome'",
					"100:class_g *= 'rofi'",
					"100:class_g *= 'Dunst'"
				];

				rounded-corners-exclude = [
				"window_type = 'tooltip'",
				"window_type = 'desktop'"
				];

				blur-background-exclude = [
				#"window_type = 'dock'",
				"window_type = 'desktop'",
				"_GTK_FRAME_EXTENTS@:c"
				];

				refresh-rate = 0;
				detect-client-leader = true;
				glx-no-rebind-pixmap = true;

				wintypes:
				{
				tooltip = { fade = true; shadow = true; opacity = 0.9; focus = true; full-shadow = false; }
				dock = { shadow = true; }
				dialog = { opacity = 1.0; }
				popup_menu = { opacity = 0.95; }
				dropdown_menu = { opacity = 0.95; }
				}
_EOF_
}

# Set dunst notification daemon config
set_dunst_config() {

			dunst -sep_color "$background" -frame_color "$color4" -nf "$foreground" -lf "$foreground" -cf "$foreground" &
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
		polybar -q bspwm-bar -c ${rice_dir}/config.ini &
}


### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_xresources_config
set_picom_config
set_dunst_config
launch_bars
