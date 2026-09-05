# 🆕 Clean & Minimal Ubuntu — Post-Install Setup Guide

> Covers **Ubuntu 24.04 LTS** and **Ubuntu 26.04 LTS**. Differences between versions are clearly marked.

> When installing Ubuntu, choose **Default Selection** (just the essentials — web browser and basic utilities).

## 💻 System Info & Useful Commands

```bash
# Check Ubuntu version
lsb_release -a
sudo dmidecode -s bios-version

# Display hostname and key system info
hostnamectl

# Show disk usage — sorted largest first
du -h -s * | sort -h -r
#If you want to delete everything under ~/.config/Code except User/settings.json, you can use find
find ~/.config/Code -mindepth 1 ! -path ~/.config/Code/User ! -path ~/.config/Code/User/settings.json -delete
```

## ⭐ Update, Upgrade, Fixes & **nala**

```bash
sudo apt update
sudo apt upgrade
# combined
sudo apt update -y && sudo apt upgrade -y
# Useful apt helpers
apt search <keyword>
sudo apt --fix-broken install
sudo apt autoremove --purge
sudo apt autopurge
```

### Install nala (better apt frontend)

```bash
sudo apt install nala

# Edit nala config for binary file sizes:
# Set to true for MiB, false for MB
sudo nano /etc/nala/nala.conf
filesize_binary = true

# or this single command
sudo sed -i '/^filesize_binary[[:space:]]*=/c\filesize_binary = true' /etc/nala/nala.conf
```

## 🔥 Purge Unnecessary Packages

### Remove Ubuntu Report & Crash Popups

**Ubuntu 24.04**

```bash
sudo apt purge ubuntu-report apport apport-gtk
```

**Ubuntu 26.04**

```bash
sudo apt purge ubuntu-report apport apport-core-dump-handler apport-gtk
```

### Ubuntu 24.04 / 26.04 — Remove Accessibility & Internationalization Packages (~390–437 MB)

```bash
# Accessibility tools (~117 MB)
sudo apt purge brltty orca gnome-accessibility-themes fonts-noto-cjk

# Optional language/input/speech packages. Blob errors, safe to ignore (~294 MB)
sudo apt purge speech-dispatcher* libpinyin* ibus* pocketsphinx* espeak* liblouis* hplip*

# Cleanup unused dependencies (~37 MB)
sudo apt autoremove --purge
```

## 🖨️ Remove Printing Support (~18–24 MB freed)

```bash
sudo apt purge 'cups*' 'foomatic*' \
  printer-driver-brlaser* \
  printer-driver-foo2zjs-common* \
  printer-driver-ptouch* \
  printer-driver-c2esp* \
  printer-driver-min12xxw* \
  printer-driver-sag-gdi*

sudo apt autoremove --purge
```

## 🧹 Remove Old Kernels

First, identify what's installed:

```bash
dpkg --list | grep -Ei 'linux-image|linux-headers|linux-tools|linux-modules|linux-hwe'
```

Then purge specific old versions (replace with actual package names):

```bash
sudo apt purge package1 package2 package3
sudo apt autopurge
sudo update-grub
```

## 🌐 Install Google Chrome

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
```

## 🎴 Install Node.js

```bash
# Node.js 22.x LTS (stable)
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
# Node.js 24.x LTS (latest)
curl -fsSL https://deb.nodesource.com/setup_24.x | sudo bash -
# Node.js 26.x LTS (latest)
curl -fsSL https://deb.nodesource.com/setup_26.x | sudo bash -

sudo nala install -y nodejs
```

## 📦 Global NPM Packages

```bash
sudo npm install -g npm@latest corepack@latest npm-check-updates typescript pnpm@latest yarn vite
# bun will be 350++ MiB
sudo npm install -g bun
sudo npm config set allow-scripts=bun,yarn --location=user

# Check for outdated global packages
sudo npm outdated -g --depth=0

# Update all global packages
sudo npm update -g
```
## 🆘 oh-my-posh Setup

### Installation

```bash
sudo bash -c "$(curl -s https://ohmyposh.dev/install.sh)" -- -d /usr/bin

# Move themes to home directory
sudo mv /root/.cache/oh-my-posh/themes/ ~/.oh-my-posh && sudo chown -R "$USER:$USER" ~/.oh-my-posh

# Use the enclosed `.bashrc` — uncomment your preferred theme at the bottom, then refresh:
exec bash
```

## 💾 Export / Load GNOME Settings

```bash
# Reset GNOME folders
gsettings reset org.gnome.desktop.app-folders folder-children

# Reset ALL user-configured GNOME settings (destructive — use carefully)
dconf reset -f /

# Export full GNOME settings
dconf dump / > ubuntu2604.conf

# Load full GNOME settings
dconf load / < ubuntu2604.conf

# Export GNOME extension settings only
dconf dump /org/gnome/shell/extensions/ > aa-gnome-exts-settings.conf

# Load GNOME extension settings only
dconf load /org/gnome/shell/extensions/ < aa-gnome-exts-settings.conf
```

## 🛸 XTRADEB Packages

Unofficial Ubuntu packages maintained by xtradeb. Prefer **chromium** over ungoogled-chromium since extensions can be installed in it.

[xtradeb PPA on Launchpad](https://launchpad.net/~xtradeb/+archive/ubuntu/apps)

```bash
sudo add-apt-repository ppa:xtradeb/apps -y
sudo nala update
sudo nala install yt-dlp parabolic calibre ungoogled-chromium chromium
```

## ✴️ Suggested & Optional Packages

```bash
# Essential Tools
sudo nala install curl git gnome-calendar gnome-shell-extension-manager gnome-tweaks nautilus-admin gedit gedit-plugins thunar 7zip

# Multimedia Plugins
sudo nala install gstreamer1.0-libav gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly libheif-plugin-libde265 gst-audio-thumbnailer  gst-video-thumbnailer

# Optional
sudo nala install adb fastboot foliate file-roller rar unrar synaptic
sudo nala install errands wike wordbook
```

### Multimedia **Ubuntu 24.04**

```bash
sudo nala install amberol totem vlc loupe
```

### Multimedia **Ubuntu 26.04**

```bash
sudo nala install gapless showtime clapper gnome-video-trimmer vlc
```

### Dev packages for mise/ruby workflow

```bash
sudo nala install build-essential libssl-dev libreadline-dev pkg-config
```

### qBittorrent

```bash
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
sudo nala install qbittorrent
```

## 🪛 Useful

[ubuntu-debullshit.sh](https://github.com/polkaulfield/ubuntu-debullshit)

Purges snaps, installs flatpaks, restores vanilla GNOME |
