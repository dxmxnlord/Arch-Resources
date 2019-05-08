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
### 3. Copy Rofi config to ~/.confgi/rofi
### 4. Copy .Xdefaults
### 5. Edit .bashrc
Add the line 
```
#To change bash prompt to undo delete/comment

export PS1="\[$(tput bold)\]\[$(tput setaf 2)\]\h\[$(tput setaf 7)\] \[$(tput setaf 6)\]{\w}\[$(tput setaf 7)\]\[$(tput sgr0)\]\[$(tput setaf 1)\] -]] \[$(tput sgr0)\]"
```
### 6. Lemonbar Configuration
1. Install the xft fork of lemonbar with `yay -S lemonbar-xft-git`
2. Install powerline fonts from [here](https://github.com/powerline/fonts) to `~/.local/share/fonts`
3. Install powerline with `yay -S powerline`
4. Install FontAwesome with `yay -S ttf-font-awesome-4`
4. Install [this font](http://graphicex.com/font/126189-vin-mono-pro-font-family.html)
5. Install `xdotool`,`acpi`,`wireless_tools`,`jq`
6. Copy the lemonbar script and the other scripts to i3 folder and give them executable permissions
### 7. Installing i3lock-color
1. Install `i3lock-color` from the repo
2. Copy the lock.sh file and call it in the config with a bindsym-exec
3. Note: sometimes you have to have i3lock installed too but call the i3lock in the x64 or i686 folder, so rename the binary then copy it to your path and call the new binary in the lock.sh (this one calls i3lock) then add a bind-sym exec to lock.sh
