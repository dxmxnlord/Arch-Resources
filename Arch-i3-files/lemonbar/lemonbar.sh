#!/bin/bash

#killall lemonbar
#bash /home/rishikesh/.config/i3/lemon.sh | lemonbar -b -p -F#FFFFFFFF -B#AA000000 -o -5 -f "Vin Mono Pro"-8 -o 0 -f "DejaVu Sans Mono for Powerline"-13 -f "FontAwesome"-8 -g 1366x18

killall lemonbar

bash | lemonbar -p -g x28 -F#00000000 -B#00000000 | 

bash /home/rishikesh/.config/i3/lemon.sh | lemonbar -d 1 -g 1366x18+0+5 -p -F#FFFFFFFF -B#00000000 -o -5 -f "Vin Mono Pro"-8 -o 0 -f "DejaVu Sans Mono for Powerline"-13 -f "FontAwesome"-8 | bash
