#!/usr/bin/env bash
#  ╔═╗╔╦╗╦╦  ╦╔═╗  ╦═╗╦╔═╗╔═╗
#  ║╣ ║║║║║  ║╠═╣  ╠╦╝║║  ║╣ 	https://github.com/gh0stzk/dotfiles
#  ╚═╝╩ ╩╩╩═╝╩╩ ╩  ╩╚═╩╚═╝╚═╝
## This file will configure the options
## and launch the bars corresponding to each theme.

# Set bspwm configuration for Emilia
set_bspwm_config() {
		bspc config top_padding 45
		bspc config bottom_padding 2
		bspc config active_border_color "#D9D7CE"
		bspc config presel_feedback_color "#73D0FF"
		bspc config left_padding 2
		bspc config right_padding 2
		bspc config window_gap 6
        bspc monitor -d 一 二 三 四 五 六 七 八		
        bspc config border_width 0
		bspc config focused_border_color "#6C6F93"
		bspc config normal_border_color "#282e3a"
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
		
		sed -i "$HOME"/.config/alacritty/rice-colors.yml \
		-e "s/colors: .*/colors: *ayu_color_scheme/"
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
				*.foreground:     #D9D7CE
				*.background:     #212733

				! black
				*.color0:         #212733
				*.color8:         #6C6F93

				! red
				*.color1:         #FFA759
				*.color9:         #FFA759

				! green
				*.color2:         #BAE67E
				*.color10:        #BAE67E

				! yellow
				*.color3:         #FFD580
				*.color11:        #FFD580

				! blue
				*.color4:         #73D0FF
				*.color12:        #73D0FF

				! magenta
				*.color5:         #c29be8
				*.color13:        #c29be8

				! cyan
				*.color6:         #73D0FF
				*.color14:        #73D0FF

				! white
				*.color7:         #D9D7CE
				*.color15:        #D9D7CE
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
		-e "s/frame_color = .*/frame_color = \"#212733\"/g" \
		-e "s/separator_color = .*/separator_color = \"#32302f\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#b8bb26'/g"
		
		sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
		command cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
				[urgency_low]
				timeout = 3
				background = "#212733"
				foreground = "#D9D7CE"

				[urgency_normal]
				timeout = 6
				background = "#212733"
				foreground = "#D9D7CE"

				[urgency_critical]
				timeout = 0
				background = "#212733"
				foreground = "#D9D7CE"
_EOF_
}

# Launch the bar
launch_bars() {
		polybar -q ayu-bar -c ${rice_dir}/config.ini &
}


### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_xresources_config
set_picom_config
set_dunst_config
launch_bars
