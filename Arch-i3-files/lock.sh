#!/bin/sh

B='#00000000'  # blank
C='#ff00ff00'  # clear ish
D='#ff00ffcc'  # default
T='#ee00ee00'  # text
W='#880000bb'  # wrong
V='#bb00bbbb'  # verifying

#./x86_64-pc-linux-gnu/i3lock \
i3lock \
--insidevercolor=$C   \
--ringvercolor=#000000FF     \
\
--insidewrongcolor=$C \
--ringwrongcolor=#FF0000FF   \
\
--insidecolor=$B      \
--ringcolor=#000000FF        \
--linecolor=$B        \
--separatorcolor=#23423400   \
\
--verifcolor=$T        \
--wrongcolor=$T        \
--timecolor=#00000000        \
--datecolor=$T        \
--layoutcolor=$T      \
--keyhlcolor=#FFFFFFaa       \
--bshlcolor=$W        \
\
--screen 1            \
--blur 5              \
--clock               \
--indicator           \
--timestr="%H:%M:%S"  \
--datestr="%A, %m %Y" \
--keylayout 2         \

# --veriftext="Drinking verification can..."
# --wrongtext="Nope!"
# --textsize=20
# --modsize=10
# --timefont=comic-sans
# --datefont=monofur
# etc
