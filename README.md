# 🆕 Clean & Minimal Ubuntu — Post-Install Setup Guide

> Covers **Ubuntu 24.04 LTS** and **Ubuntu 26.04 LTS**. Differences between versions are clearly marked.

> When installing Ubuntu, choose **Default Selection** (just the essentials — web browser and basic utilities).

## 💻 System Info & Useful Commands

```bash
# Check Ubuntu version
lsb_release -a

# Display hostname and key system info
hostnamectl

# Show disk usage — sorted largest first
du -h -s * | sort -h -r
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
sudo nano /etc/nala/nala.conf
# Edit nala config for binary file sizes:
# Set to true for MiB, false for MB
filesize_binary = true
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

## 📜 Git & SSH Setup

> Recommended for single GitHub accounts. Multiple accounts require additional configuration.

### Git Configuration

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global color.ui auto
git config --global core.editor "code --wait"
```

### SSH Setup

#### 1. Check for Existing SSH Keys

```bash
ls -al ~/.ssh
```

If keys exist, skip to steps 3 and 6.

#### 2. Generate a New SSH Key

```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
```

#### 3. Add Key to SSH Agent

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

#### 4. Copy the Public Key

```bash
cat ~/.ssh/id_ed25519.pub
```

#### Fix Permissions (if needed)

```bash
chmod 600 ~/.ssh/id_ed25519
```

#### 5. Add SSH Key to GitHub

Paste the output of step 4 into **GitHub → Settings → SSH and GPG keys → New SSH key**.

#### 6. Test the GitHub Connection

```bash
rm ~/.ssh/known_hosts
ssh-keyscan github.com >> ~/.ssh/known_hosts
ssh -T git@github.com
```

## 🆘 oh-my-posh Setup

### Installation

```bash
sudo bash -c "$(curl -s https://ohmyposh.dev/install.sh)" -- -d /usr/bin

# Move themes to home directory
sudo mv /root/.cache/oh-my-posh/themes/ ~/.oh-my-posh
sudo chown -R $USER:$USER ~/.oh-my-posh

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
dconf dump / > full-gnome-backup.conf

# Load full GNOME settings
dconf load / < full-gnome-backup.conf

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

### Essential Tools

```bash
sudo nala install curl duf git gnome-calendar gnome-shell-extension-manager gnome-tweaks nautilus-admin gedit gedit-plugins synaptic thunar
```

### Multimedia Plugins

```bash
sudo nala install gstreamer1.0-libav gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly libheif-plugin-libde265 gst-audio-thumbnailer  gst-video-thumbnailer
```

### Multimedia **Ubuntu 24.04**

```bash
sudo nala install amberol totem vlc loupe
```

### Multimedia **Ubuntu 26.04**

```bash
sudo nala install gapless showtime clapper vlc gnome-video-trimmer
```

### Optional Programs combined

```bash
sudo nala install file-roller rar unrar adb fastboot foliate
```

### Optional Programs **Ubuntu 26.04**

```bash
sudo nala install errands wike wordbook
```

### Dev packages for mise/ruby workflow

```bash
sudo nala install build-essential libssl-dev libreadline-dev pkg-config
```

### qBittorrent

```bash
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
sudo apt-get update && sudo apt-get install qbittorrent
```

## 🪛 Useful Scripts

| Script                                                                                     | Description                                             |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------- |
| [ubuntu-debullshit.sh](https://github.com/polkaulfield/ubuntu-debullshit)                  | Purges snaps, installs flatpaks, restores vanilla GNOME |
| [snap-remover.sh](https://gist.github.com/lassekongo83/808b19e034c05d10ac4e3cc259808e4e)   | Completely removes snaps from Ubuntu                    |
| [snap-cleaner.sh](https://github.com/sakibulalikhan/snap-cleaner)                          | Deletes unnecessary Snap revisions and caches           |
| [ubuntu_cleanup.sh](https://gist.github.com/Limbicnation/6763b69ab6a406790f3b7d4b56a2f6e8) | Comprehensive cleanup script to free up disk space      |
