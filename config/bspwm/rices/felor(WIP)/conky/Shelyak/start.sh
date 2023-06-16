#!/bin/bash

killall conky
sleep 2s
		
conky -c $HOME/.config/bspwm/rices/felor/conky/Shelyak/Shelyak.conf &> /dev/null &

exit
