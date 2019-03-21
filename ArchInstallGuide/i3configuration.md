# How to configure your i3-gaps

### 1. Install packages
- ##### dmenu
- ##### i3status
- ##### light
- ##### gnome-screenshot
- ##### google-chrome-stable
- ##### urxvt
- ##### gedit
- ##### pulseaudio
- ##### feh
- ##### imagemagick
- ##### pywal
### 2. Copy Config file
### 3. Copy Rofi config to ~/rofi
### 4. Copy .Xdefaults
### 5. Edit .bashrc
Add the line 
```
#To change bash prompt to undo delete/comment

export PS1="\[$(tput bold)\]\[$(tput setaf 2)\]\h\[$(tput setaf 7)\] \[$(tput setaf 6)\]{\w}\[$(tput setaf 7)\]\[$(tput sgr0)\]\[$(tput setaf 1)\] -]] \[$(tput sgr0)\]"
```
### 6. Lemonbar Configuration
1. Install the xft fork of lemonbar with `yay -S lemonbar-xft-git`
2. Install powerline fonts from [here](https://github.com/powerline/fonts)
3. Install powerline with `yay -S powerline`
4. Install FontAwesome with `yay -S ttf-font-awesome-4`
4. Install [this font](http://graphicex.com/font/126189-vin-mono-pro-font-family.html)
5. Install `xdotool`,`acpi`,`wireless_tools`,`jq`
6. Copy the lemonbar script and the other scripts
### 7. Installing i3lock-color
1. Install it with `yay -S i3lock-color-git`
2. Copy the lock.sh file and call it in the config with a bindsym-exec
