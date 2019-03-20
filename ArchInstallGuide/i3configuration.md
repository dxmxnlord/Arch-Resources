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
### 4. Copy .Xresources
### 5. Edit .bashrc
Add the line 
```
#To change bash prompt to undo delete/comment

export PS1="\[$(tput bold)\]\[$(tput setaf 2)\]\h\[$(tput setaf 7)\] \[$(tput setaf 6)\]{\w}\[$(tput setaf 7)\]\[$(tput sgr0)\]\[$(tput setaf 1)\] -]] \[$(tput sgr0)\]"
```
