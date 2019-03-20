# Basic Arch Linux Install

###### Refer to the official [Arch Installation Guide](https://wiki.archlinux.org/index.php/installation_guide).

## Steps to Install Arch Linux

- #### Connect to the internet 

Check your interface with 
```
iwconfig
```
Try:
```
ip link set <interface> up
ip link set <interface> down
```
If you get an RFKILL error run
```
echo "blacklist hp_wmi" > /etc/modprobe.d/hp.conf
rfkill unblock all
```
Now we connect using `wifi-menu` which opens up a gui

Try pinging google to check if you're connected
```
ping -c 1 www.google.com
```
- #### Update system clock
```
timedatectl set-ntp true
```
- #### Creating a partition and formatting it
Use `cfdisk` to create both a *linux filesystem* and a *linux swap*
To format the newly created partiton run
```
mkfs.ext4 /dev/sdX
mkswap /dev/sdY
swapon /dev/sdY
```
Lastly mount the partition using `mount /dev/sdX /mnt`
- #### Installing base packages
```
pacstrap /mnt base
```
This group does not include all tools from the live installation, so install the rest with pacman after the *chroot* step
### Configuring the system
- #### Generating an fstab file
```
genfstab -U /mnt >> /mnt/etc/fstab
```
- #### Entering the chroot environment
```
arch-chroot /mnt
```
**_Note_ if you need to access your Arch from a live installation run the chroot command to enter the mounted partition after mounting the partition using the mount command**
