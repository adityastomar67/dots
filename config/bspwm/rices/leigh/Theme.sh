#!/usr/bin/env bash
#  ╔═╗╔═╗╔╦╗╔╗ ╦╔═╗  ╦═╗╦╔═╗╔═╗
#  ╔═╝║ ║║║║╠╩╗║║╣   ╠╦╝║║  ║╣ 	https://github.com/gh0stzk/dotfiles
#  ╚═╝╚═╝╩ ╩╚═╝╩╚═╝  ╩╚═╩╚═╝╚═╝
## This file will configure the options
## and launch the bars corresponding to each theme.

# Set bspwm configuration for z0mbi3
set_bspwm_config() {
		bspc config border_width 0
		bspc config top_padding 3
		bspc config bottom_padding 2
		bspc config normal_border_color "#3d414f"
		bspc config active_border_color "#3d414f"
		bspc config focused_border_color "#3d414f"
		bspc config presel_feedback_color "#90ceaa"
		bspc config left_padding 79
		bspc config right_padding 2
		bspc config window_gap 6
}

if pidof -q bspc; then
	pkill -9 bspc > /dev/null
fi

# Reload terminal colors
set_term_config() {
		sed -i "$HOME"/.config/alacritty/fonts.yml \
		-e "s/family: .*/family: JetBrainsMono Nerd Font/g" \
		-e "s/size: .*/size: 9.5/g"
		
		command cat > "$HOME"/.config/alacritty/colors.yml <<- _EOF_
				# Colors (Decay, decayce variant) z0mbi3 Rice
				colors:
				  primary:
				    background: '0x0B0F10'
				    foreground: '0xc5c8c9'

				  normal:
				    black:   '0x131718'
				    red:     '0xdf5b61'
				    green:   '0x87c7a1'
				    yellow:  '0xde8f78'
				    blue:    '0x6791c9'
				    magenta: '0xbc83e3'
				    cyan:    '0x70b9cc'
				    white:   '0xc4c4c4'

				  bright:
				    black:   '0x151a1c'
				    red:     '0xee6a70'
				    green:   '0x96d6b0'
				    yellow:  '0xffb29b'
				    blue:    '0x7ba5dd'
				    magenta: '0xcb92f2'
				    cyan:    '0x7fc8db'
				    white:   '0xcccccc'
    
				  cursor:
				    cursor: '#a5b6cf'
				    text:	'#0d0f18'
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
				*.foreground:     #a5b6cf
				*.background:     #0d0f18

				! black
				*.color0:         #3d414f
				*.color8:         #3d414f

				! red
				*.color1:         #dd6777
				*.color9:         #dd6777

				! green
				*.color2:         #90ceaa
				*.color10:        #90ceaa

				! yellow
				*.color3:         #ecd3a0
				*.color11:        #ecd3a0

				! blue
				*.color4:         #86aaec
				*.color12:        #86aaec

				! magenta
				*.color5:         #c296eb
				*.color13:        #c296eb

				! cyan
				*.color6:         #93cee9
				*.color14:        #93cee9

				! white
				*.color7:         #cbced3
				*.color15:        #cbced3
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
		-e "s/frame_color = .*/frame_color = \"#0d0f18\"/g" \
		-e "s/separator_color = .*/separator_color = \"#3d414f\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#c296eb'/g"
		
		sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
		command cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
				[urgency_low]
				timeout = 3
				background = "#0d0f18"
				foreground = "#a5b6cf"

				[urgency_normal]
				timeout = 6
				background = "#0d0f18"
				foreground = "#a5b6cf"

				[urgency_critical]
				timeout = 0
				background = "#0d0f18"
				foreground = "#a5b6cf"
_EOF_
}

# Launch the bar and or eww widgets
launch_bars() {
		eww -c ${rice_dir}/lei open bar &
}


### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_xresources_config
set_picom_config
set_dunst_config
launch_bars