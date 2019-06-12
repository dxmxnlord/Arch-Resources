#!/usr/bin/bash

Time(){
	echo -e -n "$(date "+%I:%M:%S")"
}

Date(){
    echo -e -n "$(date "+%m.%d.%y")"
}

ActiveWorkspace(){
    echo -n -e $(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')
}

InactiveWorkspace(){
    echostr=""
    for lworkspace in $(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==false).name'); do 
    echostr="${echostr}%{A:i3-msg workspace '${lworkspace}':}${lworkspace} %{A}"
    done
    echo -e -n "$echostr"
}

ActiveWindow(){
# 	echo -n $(xdotool getwindowfocus getwindowname)
#      if [ echo $(xprop -id $(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5) WM_NAME | sed -e 's/.*"\(.*\)".*/\1/') | grep -i -o 'Google Chrome' ]; then
#         echo -n -e "Google Chrome"
#      else
#         echo -n -e "$(xprop -id $(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5) WM_NAME | sed -e 's/.*"\(.*\)".*/\1/')"
#      fi
    if [ $(echo "$(xprop -id $(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5) WM_NAME | sed -e 's/.*"\(.*\)".*/\1/')" | grep -e 'Google Chrome') ]; then 
        echo -n -e "Google Chrome"
    else
        echo -n -e $(xprop -id $(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5) WM_CLASS | sed -e 's/.*"\(.*\)".*/\1/')
    fi
}

Battery() {
	BATTACPI=$(acpi --battery)
	BATPERC=$(echo $BATTACPI | cut -d, -f2 | tr -d '[:space:]')

	if [[ $BATTACPI == *"100%"* ]]
	then
		echo -e -n "\uf00c $BATPERC"
	elif [[ $BATTACPI == *"Discharging"* ]]
	then
		BATPERC=${BATPERC::-1}
		if [ $BATPERC -le "10" ]
		then
			echo -e -n "\uf244"
		elif [ $BATPERC -le "25" ]
		then
			echo -e -n "\uf243"
		elif [ $BATPERC -le "50" ]
		then
			echo -e -n "\uf242"
		elif [ $BATPERC -le "75" ]
		then
			echo -e -n "\uf241"
		elif [ $BATPERC -le "100" ]
		then
			echo -e -n "\uf240"
		fi
		echo -e " $BATPERC%"
	elif [[ $BATTACPI == *"Charging"* && $BATTACPI != *"100%"* ]]
	then
		echo -e "\uf0e7 $BATPERC"
	elif [[ $BATTACPI == *"Unknown"* ]]
	then
		echo -e "$BATPERC"
	fi
}

Volume(){
    echo -n "$(bash ~/.config/i3/volume_pulseaudio)"
}

Wifi(){
	WIFISTR=$( iwconfig wlp1s0 | grep "Link" | sed 's/ //g' | sed 's/LinkQuality=//g' | sed 's/\/.*//g')
	if [ ! -z $WIFISTR ] ; then
		WIFISTR=$(( ${WIFISTR} * 100 / 70))
		ESSID=$(iwconfig wlp1s0 | grep ESSID | sed 's/ //g' | sed 's/.*://' | cut -d "\"" -f 2)
		if [ $WIFISTR -ge 1 ] ; then
			echo -e "\uf1eb ${ESSID} ${WIFISTR}%"
		fi
	else
		echo "wlp1s0 down"
	fi
}

Disk(){
DIR="${BLOCK_INSTANCE:-$HOME}"
ALERT_LOW="${1:-10}"

df -h -P -l "$DIR" | awk -v alert_low=$ALERT_LOW '
/\/.*/ {
	# full text
	holder=" "
	print holder $4

	use=$5

	# no need to continue parsing
	exit 0
}

END {
	gsub(/%$/,"",use)
	if (100 - use < alert_low) {
		# color
		print "#FF0000"
	}
}
'
}

Sound(){
	NOTMUTED=$( amixer sget Master | grep "\[on\]" )
	if [[ ! -z $NOTMUTED ]] ; then
		VOL=$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master) | sed 's/%//g')
		if [ $VOL -ge 85 ] ; then
			echo -e "\uf028 ${VOL}%"
		elif [ $VOL -ge 50 ] ; then
			echo -e "\uf027 ${VOL}%"
		else
			echo -e "\uf026 ${VOL}%"
		fi
	else
		echo -e "\uf026 M"
	fi
}

GetColors(){
hexa=""
flag=0
count=0
for col in $(cat ~/.cache/wal/colors.css | grep -o '#......'); do
	if [ $count -lt 3 ]; then
		((count++))
		continue
	fi
	for colcheck in ${hexa}; do
		if [ $col == $colcheck ]; then
			flag=1
			break
		fi
	done
	if [ $flag -eq 0 ]; then
		hexa="${hexa} $col"
	else
		flag=0
	fi	
	((count++))
done
echo "$hexa"
}

WalMain(){

count=0
color[0]=nothing
for hexcolor in $(GetColors); do
hexinput=`echo "$hexcolor" | grep -o -e '[0-9a-zA-Z]*' | tr '[:lower:]' '[:upper:]'`
a=`echo $hexinput | cut -c-2`
b=`echo $hexinput | cut -c3-4`
c=`echo $hexinput | cut -c5-6`
r=`echo "ibase=16; $a" | bc`
g=`echo "ibase=16; $b" | bc`
b=`echo "ibase=16; $c" | bc`
minval=200
if [ $2 ]; then
    minval=$2
fi
amt=10
if [ $1 ]; then
    amt=$1
fi
if [ $r -gt ${minval} ] || [ $g -gt ${minval} ] || [ $b -gt ${minval} ]; then
    r=$(expr ${r} - ${amt} \* ${r} / 100)
    b=$(expr ${b} - ${amt} \* ${b} / 100)
    g=$(expr ${g} - ${amt} \* ${g} / 100)
fi
hexcolor=$(printf \#%02X%02X%02X $r $g $b) 
color[${count}]=$hexcolor
((count++))
done

bkgd=#00000000

while true; do

	COMMAND="$@"
	FOCUSED=$(xprop -root _NET_ACTIVE_WINDOW | awk -F' ' '{print $NF}')

	if xprop -id ${FOCUSED} _NET_WM_STATE | grep -i _NET_WM_STATE_FULLSCREEN; then
		echo ""
	else
	    #echo -e "%{l}%{B${color[0]}} $(ActiveWorkspace) %{B-}%{F${color[0]} B${color[1]}}\ue0b0%{F- B-}%{B${color[1]}} $(InactiveWorkspace)%{B-}%{F${color[1]} B$bkgd}\ue0b0%{F- B-}" "%{c}%{F${color[2]} B$bkgd}\ue0b2%{F- B-}%{B${color[2]}} $(ActiveWindow) %{B-}%{F${color[2]} B$bkgd}\ue0b0%{F- B-}" "%{r}%{F${color[3]}}%{B$bkgd}\ue0b2%{F-}%{B-}%{B${color[3]}} $(Disk) %{B-}%{F${color[4]}}%{B${color[3]}}\ue0b2%{F-}%{B-}%{B${color[4]}}%{A:networkmanager_dmenu:} $(Wifi) %{A}%{B-}%{F${color[5]}}%{B${color[4]}}\ue0b2%{F-}%{B-}%{B${color[5]}} $(Battery) %{B-}%{F${color[6]}}%{B${color[5]}}\ue0b2%{F-}%{B-}%{B${color[6]}} $(Volume) %{B-}%{F${color[7]}}%{B${color[6]}}\ue0b2%{B-}%{F-}%{B${color[7]}} $(Date)  $(Time) %{B-}"
	    echo -e "%{l}%{B${color[0]}} $(ActiveWorkspace) %{B-}%{F${color[0]} B${color[1]}}\ue0b0%{F- B-}%{B${color[1]}} $(InactiveWorkspace)%{B-}%{F${color[1]} B$bkgd}\ue0b0%{F- B-}" "%{r}%{F${color[3]}}%{B$bkgd}\ue0b2%{F-}%{B-}%{B${color[3]}} $(Disk) %{B-}%{F${color[4]}}%{B${color[3]}}\ue0b2%{F-}%{B-}%{B${color[4]}}%{A:networkmanager_dmenu:} $(Wifi) %{A}%{B-}%{F${color[5]}}%{B${color[4]}}\ue0b2%{F-}%{B-}%{B${color[5]}} $(Battery) %{B-}%{F${color[6]}}%{B${color[5]}}\ue0b2%{F-}%{B-}%{B${color[6]}} $(Volume) %{B-}%{F${color[7]}}%{B${color[6]}}\ue0b2%{B-}%{F-}%{B${color[7]}} $(Date)  $(Time) %{B-}"
	fi

	sleep 0.1s
done
}

Main(){

greyL=#6A6A6A
greyM=#4A4A4A
greyD=#2d2d2d
active=#6A6A6A
inactive=#4A4A4A
focus=#3A3A3A

while true; do


	COMMAND="$@"
	FOCUSED=$(xprop -root _NET_ACTIVE_WINDOW | awk -F' ' '{print $NF}')

	if xprop -id ${FOCUSED} _NET_WM_STATE | grep -i _NET_WM_STATE_FULLSCREEN; then
		echo ""
	else
		#echo -e "%{l}%{B$active} $(ActiveWorkspace) %{B-}%{F$active B$inactive}\ue0bc%{F- B-}%{B$inactive} $(InactiveWorkspace)%{B-}%{F$inactive B$bkgd}\ue0bc%{F- B-}" "%{c}$(ActiveWindow)" "%{r}%{F$greyM}%{B$bkgd}\ue0b2%{F-}%{B-}%{B$greyM} $(Disk) %{B-}%{F$greyL}%{B$greyM}\ue0b2%{F-}%{B-}%{B$greyL} $(Wifi) %{B-}%{F$greyD}%{B$greyL}\ue0b2%{F-}%{B-}%{B$greyD} $(Battery) %{B-}%{F$greyM}%{B$greyD}\ue0b2%{F-}%{B-}%{B$greyM} $(Volume) %{B-}%{F$greyL}%{B$greyM}\ue0b2%{B-}%{F-}%{B$greyL} $(Date) # $(Time) %{B-}"
		echo -e -n "%{l}%{B$active} $(ActiveWorkspace) %{B-}%{F$active B$inactive}\ue0b0%{F- B-}%{B$inactive} $(InactiveWorkspace)%{B-}%{F$inactive B$bkgd}\ue0b0%{F- B-}" "%{c}%{F$focus B$bkgd}\ue0b2%{F- B-}%{B$focus} $(ActiveWindow) %{B-}%{F$focus B$bkgd}\ue0b0%{F- B-}" "%{r}%{F$greyM}%{B$bkgd}\ue0b2%{F-}%{B-}%{B$greyM} $(Disk) %{B-}%{F$greyL}%{B$greyM}\ue0b2%{F-}%{B-}%{B$greyL}%{A:networkmanager_dmenu:} $(Wifi) %{A}%{B-}%{F$greyD}%{B$greyL}\ue0b2%{F-}%{B-}%{B$greyD} $(Battery) %{B-}%{F$greyM}%{B$greyD}\ue0b2%{F-}%{B-}%{B$greyM} $(Volume) %{B-}%{F$greyL}%{B$greyM}\ue0b2%{B-}%{F-}%{B$greyL} $(Date)  $(Time) %{B-}"
	fi
	sleeps 0.1s

done
}

# Choose the type of bar

# 1. Normal Lemonbar
# Main

# 2. Lemonbar with pywal support
# The code auto darkens the lighter colors 
# The first argument is how much you want to darken the light colors by and the second argument is the minimum value beyond which you want the color to darken

WalMain 50 100
