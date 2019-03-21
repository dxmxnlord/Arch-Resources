#!/bin/bash

killall lemonbar
bash /home/rishikesh/.config/i3/lemon.sh | lemonbar -b -p -F#FFFFFFFF -B#AA000000 -o -5 -f "Vin Mono Pro"-8 -o 0 -f "DejaVu Sans Mono for Powerline"-13 -f "FontAwesome"-8 -g 1366x18
