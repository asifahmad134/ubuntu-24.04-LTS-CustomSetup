# 🆕🆒🆓 Clean Ubuntu (24.04+)

# _Make Ubuntu great again!!!!!_

When installing Ubuntu, choose **_DEFAULT SELECTION_** === _(Just the essentials, web browser and basic utilities)_.
All of the below removal and installation is to make ubuntu more better and suitable for development.

# 🔥🔥🔥 PURGE without loosing ubuntu-desktop

- First remove snaps either with commands or scripts of your choice,
- then purge apps as below,
- then install apps of your choice,
- at the end, either run scripts or use bleachbit to cleanup the installation

### purge snaps with these commands, step by step

```
sudo snap list
sudo snap remove --purge <snap name>
sudo apt autopurge snapd
sudo rm -Rf /var/cache/snapd/
rm -Rf ~/snap
sudo apt autoremove --purge
```

### purge these, combined (444+ MB freed)

```
sudo apt purge ubuntu-report apport apport-gtk brltty orca gnome-accessibility-themes fonts-noto-cjk speech-dispatcher* libpinyin* ibus* pocketsphinx* espeak* liblouis* hplip* eog
```

### Remove bunch of CUPS stuff, also printing & printer drivers (21+ MB freed)

```
sudo apt purge 'cups*' 'foomatic*' printer-driver-brlaser* printer-driver-foo2zjs-common* printer-driver-ptouch* printer-driver-c2esp* printer-driver-min12xxw* printer-driver-sag-gdi*
```

### CLEAN remaining packages, (45+ MB freed)

```
sudo apt autoremove --purge
//or
sudo apt autopurge
```

### Remove all backgrounds (152+ MB freed), except for 25.04 default background.

```
sudo rm -fdr /usr/share/backgrounds/!("warty-final-ubuntu.png")
```

### for removing old kernels, first identify installed and then proceed

```
dpkg --list | grep -i linux-image
sudo apt purge linux-image-[version]-generic
dpkg --list | grep -i linux-headers
sudo apt purge linux-headers-[version]*
sudo apt autopurge
sudo update-grub
```

# ⭐⭐⭐ INSTALLATIONS

```
sudo apt update -y && sudo apt upgrade -y
apt search <keyword>
sudo apt --fix-broken install
```

## ✴️✴️✴️ necessary packages (125+ MB required)

```
sudo apt install amberol curl git gnome-shell-extension-manager gnome-tweaks loupe  showtime transmission tree foliate systemd-zram-generator
```

## ✳️✳️✳️ suggestions / optional packages

```
sudo apt install nautilus-admin gedit gedit-plugins
sudo apt install thunar thunar-media-tags-plugin
sudo apt install ptyxis vlc file-roller rar unrar synaptic gnome-decoder adb fastboot gh lsd gnome-calendar
```

## 🌐🌐🌐 Install Google Chrome

```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
```

## 🎴🎴🎴 Install Node.js 22.x LTS, 24.x Current

```
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
curl -fsSL https://deb.nodesource.com/setup_24.x | sudo bash -
sudo apt install -y nodejs
// important global packages needed for development
sudo npm install -g npm@latest npm-check-updates typescript pnpm yarn vite
sudo npm outdated -g --depth=0
sudo npm update -g
```

## 🆘🆘🆘 oh-my-posh in /usr/bin

```
sudo bash -c "$(curl -s https://ohmyposh.dev/install.sh)" -- -d /usr/bin
// move themes dir,
sudo mv /root/.cache/oh-my-posh/themes/ ~/.oh-my-posh
sudo chmod 777 .oh-my-posh/
// add this line at the end of .bashrc
eval "$(oh-my-posh init bash --config ~/jandedobbeleer.omp.json)"
// refresh bash after selection of each theme
exec bash
```

#### Description of files in oh-my-posh folder

- all are changed/modded themes in this folder, except....
- **_25-04.bashrc_**<br>
  This is default .bashrc in ubuntu 25.04
- **_omp.bashrc_**<br>
  This is default .bashrc with omp themes commented at the end
- **_Microsoft.PowerShell_profile.ps1_**<br>
  This is for windows 10/11 terminal/powershell profile in user's My Documents folder

# 🛸👽🚚 XTRADEB packages

Unofficial Ubuntu application packages maintained by xtradeb.

[xtradeb](https://launchpad.net/~xtradeb/+archive/ubuntu/apps)<br>

```
sudo add-apt-repository ppa:xtradeb/apps -y
sudo apt update
sudo apt install  yt-dlp parabolic calibre ungoogled-chromium chromium  gnucash  intellij-idea-community  pycharm-community
```

# ⚛️⚛️⚛️ Remove language locales for chrome & electron based apps (50+ MB each)

```
- google-chrome
sudo rm /opt/google/chrome/locales/!("en-GB.pak"|"en-US.pak")
- brave browser
sudo rm /opt/brave.com/brave/locales/!("en-GB.pak"|"en-US.pak")
- slack
sudo rm /usr/lib/slack/locales/!("en-GB.pak"|"en-US.pak") && sudo rm /usr/lib/slack/LICENSE /usr/lib/slack/resources/LICENSES.chromium.html
- TickTick
sudo rm /opt/TickTick/locales/!("en-GB.pak"|"en-US.pak") && sudo rm /opt/TickTick/LICENSE.electron.txt /opt/TickTick/LICENSES.chromium.html
- replit
sudo rm /usr/lib/replit/locales/!("en-GB.pak"|"en-US.pak") && sudo rm /usr/lib/replit/LICENSES.chromium.html
- vscode
sudo rm /usr/share/code/LICENSES.chromium.html /usr/share/code/resources/app/LICENSE.rtf && sudo rm /usr/share/code/locales/!("en-GB.pak"|"en-US.pak") && sudo rm -fdr /usr/share/code/resources/app/licenses
```

# 📦📦📦 git && ssh setup

## git conf

```
git config --global user.name "---"
git config --global user.email "---"
git config --global color.ui auto
git config --global --add safe.directory /mnt/d/make-ubuntu-great-again
```

## ssh SETUP

✅ 1. Check for Existing SSH Keys (if Yes, do steps 3 & 6)

```
ls -al ~/.ssh
```

✅ 2. Generate a New SSH Key (only if above don't exist)

```
ssh-keygen -t ed25519 -C "--email--"
```

✅ 3. Add SSH Key to SSH Agent

```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

✅ 4. Copy the Public Key (only if new is generated)

```
cat ~/.ssh/id_ed25519.pub
```

#### WARNING: UNPROTECTED PRIVATE KEY FILE!/ NOT accessible by others

```
chmod 600 /home/asif/.ssh/id_ed25519
```

✅ 5. Add SSH Key to GitHub (generated in steps 2 & 4)
✅ 6. Test the GitHub Connection

```
rm ~/.ssh/known_hosts
ssh-keyscan github.com >> ~/.ssh/known_hosts
ssh -T git@github.com
```

# 🪛📜💻 Important Scripts

#### Best all in one tool

> [ubuntu-debullshit.sh](https://github.com/polkaulfield/ubuntu-debullshit)
> Purges snaps, installs flatpaks, and restores vanilla GNOME

#### SNAP Uninstallers / Removers

> [snap-remover.sh](https://gist.github.com/lassekongo83/808b19e034c05d10ac4e3cc259808e4e)
> Completely remove snaps from Ubuntu.
>
> [unsnap](https://github.com/popey/unsnap)
> Quickly migrate from using snap packages to flatpaks

#### Cleaners

> [snap-cleaner.sh](https://github.com/sakibulalikhan/snap-cleaner)
> Free up disk space by deleting unnecessary Snap package revisions and caches.
>
> [ubuntu_cleanup.sh](https://gist.github.com/Limbicnation/6763b69ab6a406790f3b7d4b56a2f6e8)
> A comprehensive system cleanup script that safely removes unnecessary files to free up disk space (also included in this repo)

#### Miscellaneous

> **_update-all-icon-caches.sh_** This updates icons caches

# ✅✅✅ Use systemd-zram-generator — Best for Ubuntu 24.04+ and newer

This is the modern, upstream-supported way to enable ZRAM. It’s fast, efficient, flexible, and maintained directly by systemd developers. Since Ubuntu 25.04 inherits these improvements, this method is more future-proof than older zram-tools.

##🔧 Steps for Optimal ZRAM Setup with 8GB RAM

#### Install the generator

```
sudo apt update
sudo apt install systemd-zram-generator
```

#### Create config file / Recommended config for 8GB RAM

```
sudo nano /etc/systemd/zram-generator.conf

[zram0]
zram-size = ram / 2
compression-algorithm = zstd
```

#### Apply changes / Verify

```
sudo systemctl daemon-reexec
// or reboot
cat /proc/swaps
swapon --show
```
