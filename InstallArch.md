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
Now we connect using `wifi-menu` which opens up a GUI

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
- #### Timezone and Localization
To see availible timezones, **exit chroot** and type `timedatectl list-timezones`
```
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
```
Open /etc/locale.gen and uncomment *en_US.UTF-8 UTF-8* then run
```
locale-gen
touch /etc/locale.conf
echo "LANG=en_US.UTF-8" > /etc/locale.conf
```
- #### Network configuration
```
echo "<hostname>" > /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1	localhost" >> /etc/hosts
echo "127.0.1.1	dxmxnlord.localdomain	dxmxnlord" >> /etc/hosts
```
- #### Creating users and setting password
Set the root password
```
passwd
```
Create a new User and add a password
```
useradd -m -G wheel,users -s /bin/bash <username>
passwd <username>
```
To edit the sudo privileges of the user install `vim` then run `export VISUAL=vim; visudo`.
Below the line *root ALL=(ALL) ALL* add *<username> ALL=(ALL) ALL* and save the file.
- #### Microcode for the bootloader
Refer to [Arch Microcodes](https://wiki.archlinux.org/index.php/Microcode) for other cases but for an amd cpu
```
pacman -S amd-ucode
```
- #### Bootloader
Refer to the [Bootloader](https://wiki.archlinux.org/index.php/Arch_boot_process#Boot_loader) section of the wiki.
If you dont have GRUB then [install it](https://wiki.archlinux.org/index.php/GRUB) and run
```
grub-mkconfig -o /boot/grub/grub.cfg
```
If you have the GRUB loader and another linux OS then boot into the OS and run `sudo update-grub`
- #### Exit the live environment and reboot
```
exit
reboot
```
### And that's it! You now have a basic install of Arch Linux!
