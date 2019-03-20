# Configuring Your Arch Linux
### 1. Installing an AUR helper
To install `yay` run
```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```
### 2. Installing an authentication agent
i3 doesn't come with an authentication agent so we need to install one instead. Refer to the [Polkit section](https://wiki.archlinux.org/index.php/Polkit) of the wiki for more info. So install `polkit-kde-agent` and add `exec --no-startup-id /usr/lib/polkit-kde-authentication-agent-1` to your i3 config to autostart it on login.
#### Further polkit configuration
- ##### run commands without authentication
Create a new file */etc/polkit-1/rules.d/00-early-checks.rules* and add the code below where the ACTION can be found inside the corresponding policy in */usr/share/polkit-1/actions*. For example ACTION could be *org.archlinux.pkexec.gparted* which is inside the *org.archlinux.pkexec.gparted.policy* file.
```
polkit.addRule(function(action, subject) {
    if (action.id == "<ACTION>" &&
        subject.isInGroup("admin")) {
        return polkit.Result.YES;
    }
});
```
- ##### make polkit ask for root password instead
Create a new file */etc/polkit-1/rules.d/49-rootpw_global.rules* and add
```
polkit.addAdminRule(function(action, subject) {
    return ["unix-user:root"];
});
```
### 3. Fix fonts on Firefox/Chrome
Just run `fc-cache -rv` 
### 4. Change GTK theme and icon theme
Get a GTK theme and copy it to `/usr/share/themes/`. Icons go to `/usr/share/icons/`. Change with `lxappearance`
### 5. Change SDDM theme
Get an SDDM theme and copy it to `/usr/share/sddm/themes/`.  

*You can test a theme by running `sddm-greeter --test-mode --theme /usr/share/sddm/themes/<theme>`*  

The default configuration file for SDDM can be found at `/usr/lib/sddm/sddm.conf.d/default.conf`. For any changes, create a configuration file in `/etc/sddm.conf.d/` which is a copy of the default config file.
