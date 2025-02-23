set -g @base "#12121e"
set -g @text "#e0def4"
set -g @love "#FF789E"
set -g @rose "#ebbcba"
set -g @foam "#9ccfd8"
set -g @gold "#f6c177"
set -g @iris "#c4a7e7"
set -g @overlay "#26233a"
# set -g @inactive "#555169"
# set -g @surface "#1e1e2e"

set -g @session "#[bg=#{@rose} fg=#{@base} bold] #S "
set -g @user "#[bg=#{@overlay} fg=#{@rose} none] #(whoami) "
set -g @window-info "#[bg=default fg=#{@text}] #I::#P"
set -g @window-format "#I:#W#F"

set -g @time "#[bg=#{@rose} fg=#{@base} bold] %H:%M:%S "
set -g @date "#[bg=#{@overlay} fg=#{@rose} none] %a %d %b "

set -gF status-interval 1
set -gF status-justify absolute-centre

set -gF message-command-style "bg=default fg=#{@text}"
set -gF message-style "bg=default fg=#{@text}"

set -gF status-left "#{@session}#{@user}#{@window-info}"
set -gF status-left-length 150

set -gF status-right "#h #{@date}#{@time}"
set -gF status-right-length 150

set -gF status-style "bg=default fg=#{@text}"

set -gF pane-active-border-style "bg=default fg=#{@gold}"
set -gF pane-border-style "bg=default fg=#{@base}"

set -gF window-status-format " #{@window-format} "
set -gF window-status-current-format " #{@window-format} "
set -gF window-status-activity-style "bg=#{@love} fg=#{@base} bold" # when something is wrong in window
set -gF window-status-current-style "bg=#{@foam} fg=#{@base} bold" # active window indicator
set -gF window-status-separator ""

set -gF clock-mode-style 24
set -gF clock-mode-colour "#{@iris}" # press <prefix> + t

set -gF mode-style "bg=#{@overlay} fg=#{@rose}" # scoll mode indicator and selection

set -gF copy-mode-match-style "bg=#{@foam} fg=#{@base}"
set -gF copy-mode-current-match-style "bg=#{@love} fg=#{@base}"

set -gF display-panes-colour "#{@foam}"
set -gF display-panes-active-colour "#{@love}"