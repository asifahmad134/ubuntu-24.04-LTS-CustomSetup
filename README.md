# 🆕🆒🆓 Clean & Minimal Ubuntu (24.04 LTS)

When installing Ubuntu, choose **DEFAULT SELECTION** (Just the essentials, web browser and basic utilities). All of the below removal and installation is to make Ubuntu more suitable for development.

---

## ⭐⭐⭐ First: Update & Upgrade

```bash
sudo apt update
sudo apt install nala
sudo nala full-upgrade

sudo apt update -y && sudo apt upgrade -y
apt search <keyword>
sudo apt --fix-broken install
sudo apt autoremove --purge
sudo apt autopurge
```

### Configure Nala

Edit `/etc/nala/nala.conf`:

```bash
# Set to true to make full-upgrade the default
full_upgrade = true

# Set to true: Nala will list the upgradable packages automatically after `update`
update_show_packages = true

# Set to true for `MiB` false for `MB`
filesize_binary = true
```

---

## 🔥🔥🔥 Purge Unnecessary Packages Without Losing ubuntu-desktop

**Steps:**
1. Remove snaps (commands or scripts)
2. Purge unwanted apps
3. Install apps of your choice
4. Run cleanup scripts or use BleachBit

### Purge Snaps (Step by Step)

```bash
sudo snap list

# Remove individual snaps
sudo snap remove --purge firefox firmware-updater
sudo snap remove --purge gnome-42-2204 gtk-common-themes
sudo snap remove --purge snap-store snapd-desktop-integration bare
sudo snap remove --purge core22
sudo snap remove --purge snapd

# Clean up snap directories
sudo rm -Rf /var/cache/snapd/
rm -Rf ~/snap
sudo apt autoremove --purge
```

### Purge Accessibility & Internationalization Packages (390+47 MB freed)

```bash
sudo apt purge ubuntu-report apport apport-gtk brltty orca gnome-accessibility-themes fonts-noto-cjk speech-dispatcher* libpinyin* ibus* pocketsphinx* espeak* liblouis* hplip* eog
sudo apt autoremove --purge
```

### Remove Printing Support (18+5 MB freed)

```bash
sudo apt purge 'cups*' 'foomatic*' printer-driver-brlaser* printer-driver-foo2zjs-common* printer-driver-ptouch* printer-driver-c2esp* printer-driver-min12xxw* printer-driver-sag-gdi*
sudo apt autoremove --purge
```

### Remove All Backgrounds (50+ MB) - Optional

```bash
sudo rm -fdr /usr/share/backgrounds/*
```

### Remove Old Kernels

First, identify installed kernels:

```bash
dpkg --list | grep -i linux-image
dpkg --list | grep -i linux-headers
```

Then remove specific versions:

```bash
sudo apt purge linux-image-[version]-generic
sudo apt purge linux-headers-[version]-generic
sudo apt autopurge
sudo update-grub
```

---

## ✴️✴️✴️ Suggested / Optional Packages

### Essential Development Tools

```bash
sudo nala install curl git gnome-shell-extension-manager gnome-tweaks loupe transmission tree foliate systemd-zram-generator lsd
sudo nala install nautilus-admin gedit gedit-plugins
sudo nala install thunar thunar-media-tags-plugin
sudo nala install totem amberol gstreamer1.0-libav
```

### Optional Utilities

```bash
sudo nala install ptyxis vlc file-roller rar unrar synaptic gnome-decoder adb fastboot gh gnome-calendar
```

---

## 🌐🌐🌐 Install Latest Google Chrome

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
```

---

## 🎴🎴🎴 Install Node.js

### Node.js 22.x LTS

```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
sudo apt install -y nodejs
```

### Node.js 24.x Current

```bash
curl -fsSL https://deb.nodesource.com/setup_24.x | sudo bash -
sudo apt install -y nodejs
```

### Global NPM Packages

```bash
sudo npm install -g npm@latest npm-check-updates typescript pnpm yarn vite
sudo npm outdated -g --depth=0
sudo npm update -g
```

---

## 🆘🆘🆘 oh-my-posh Setup

### Installation

```bash
sudo bash -c "$(curl -s https://ohmyposh.dev/install.sh)" -- -d /usr/bin

# Move themes directory
sudo mv /root/.cache/oh-my-posh/themes/ ~/.oh-my-posh
sudo chmod 777 .oh-my-posh/
```

### Configure Bash

Add this line at the end of `~/.bashrc`:

```bash
eval "$(oh-my-posh init bash --config ~/.oh-my-posh/jandedobbeleer.omp.json)"
```

Refresh bash after selecting theme:

```bash
exec bash
```

### Description of Files in oh-my-posh Folder

- All themes are changed/modded versions
- **25-04.bashrc** - Default .bashrc in Ubuntu 25.04
- **omp.bashrc** - Default .bashrc with omp themes commented at the end
- **Microsoft.PowerShell_profile.ps1** - For Windows 10/11 terminal/PowerShell profile in user's Documents folder

---

## 🛸💽🚚 XTRADEB Packages

Unofficial Ubuntu application packages maintained by xtradeb.

[xtradeb PPA](https://launchpad.net/~xtradeb/+archive/ubuntu/apps)

```bash
sudo add-apt-repository ppa:xtradeb/apps -y
sudo nala update
sudo nala install yt-dlp parabolic calibre ungoogled-chromium chromium gnucash intellij-idea-community pycharm-community
```

---

## ⚛️⚛️⚛️ Remove Language Locales (50+ MB per app)

Remove unused locales from Chrome & Electron-based apps:

### Google Chrome

```bash
sudo rm /opt/google/chrome/locales/!("en-GB.pak"|"en-US.pak")
```

### Brave Browser

```bash
sudo rm /opt/brave.com/brave/locales/!("en-GB.pak"|"en-US.pak")
```

### Cursor

```bash
sudo rm /usr/share/cursor/resources/app/ThirdPartyNotices.txt /usr/share/cursor/LICENSES.chromium.html /usr/share/cursor/resources/app/LICENSE.txt
sudo rm /usr/share/cursor/locales/!("en-GB.pak"|"en-US.pak")
```

### Slack

```bash
sudo rm /usr/lib/slack/locales/!("en-GB.pak"|"en-US.pak")
sudo rm /usr/lib/slack/LICENSE /usr/lib/slack/resources/LICENSES.chromium.html
```

### TickTick

```bash
sudo rm /opt/TickTick/locales/!("en-GB.pak"|"en-US.pak")
sudo rm /opt/TickTick/LICENSE.electron.txt /opt/TickTick/LICENSES.chromium.html
```

### Replit

```bash
sudo rm /usr/lib/replit/locales/!("en-GB.pak"|"en-US.pak")
sudo rm /usr/lib/replit/LICENSES.chromium.html
```

### VS Code

```bash
sudo rm /usr/share/code/resources/app/ThirdPartyNotices.txt /usr/share/code/LICENSES.chromium.html /usr/share/code/resources/app/LICENSE.rtf
sudo rm /usr/share/code/locales/!("en-GB.pak"|"en-US.pak")
sudo rm -fdr /usr/share/code/resources/app/licenses
```

---

## 📦📦📦 Git & SSH Setup

### Git Configuration

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global color.ui auto
```

### SSH Setup

#### ✅ 1. Check for Existing SSH Keys

```bash
ls -al ~/.ssh
```

If keys exist, proceed to steps 3 & 6.

#### ✅ 2. Generate a New SSH Key (if none exist)

```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
```

#### ✅ 3. Add SSH Key to SSH Agent

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

#### ✅ 4. Copy the Public Key

```bash
cat ~/.ssh/id_ed25519.pub
```

#### Fix Permissions (if needed)

```bash
chmod 600 ~/.ssh/id_ed25519
```

#### ✅ 5. Add SSH Key to GitHub

Add the public key from step 4 to your GitHub account settings.

#### ✅ 6. Test the GitHub Connection

```bash
rm ~/.ssh/known_hosts
ssh-keyscan github.com >> ~/.ssh/known_hosts
ssh -T git@github.com
```

---

## 🪛📜💻 Important Scripts

### All-in-One Tool

**[ubuntu-debullshit.sh](https://github.com/polkaulfield/ubuntu-debullshit)**  
Purges snaps, installs flatpaks, and restores vanilla GNOME.

### Snap Uninstallers / Removers

**[snap-remover.sh](https://gist.github.com/lassekongo83/808b19e034c05d10ac4e3cc259808e4e)**  
Completely remove snaps from Ubuntu.

**[unsnap](https://github.com/popey/unsnap)**  
Quickly migrate from snap packages to flatpaks.

### Cleaners

**[snap-cleaner.sh](https://github.com/sakibulalikhan/snap-cleaner)**  
Free up disk space by deleting unnecessary Snap package revisions and caches.

**[ubuntu_cleanup.sh](https://gist.github.com/Limbicnation/6763b69ab6a406790f3b7d4b56a2f6e8)**  
A comprehensive system cleanup script that safely removes unnecessary files to free up disk space.

### Miscellaneous

**update-all-icon-caches.sh** - Updates icon caches.

---

## 🧠 Understanding zram Compression in Linux

### What is zram?

**zram** is a Linux kernel module that creates a compressed block device in RAM. It allows your system to use compressed memory for swap space or temporary storage, improving performance under memory pressure.

### ⚙️ How zram Works

When your system runs low on free RAM:

1. Normally, Linux swaps inactive memory pages to disk (slow)
2. With **zram**, those pages are compressed and kept in RAM
3. This means faster access times since compressed RAM is much faster than disk I/O
4. The CPU handles compression/decompression automatically

### 📈 Benefits

| Advantage           | Description                               |
|---------------------|-------------------------------------------|
| 🚀 Faster swapping  | No disk I/O – data stays in RAM           |
| 💾 Reduced SSD wear | Less frequent writing to swap partitions  |
| ⚡ Better multitasking | Keeps your system responsive under load |
| 🔋 Energy efficient | Reduces disk activity on laptops          |

### ⚖️ Trade-offs

- Uses CPU for compression/decompression (minimal on modern CPUs)
- Consumes a portion of RAM for compressed data
- Not as beneficial on systems with lots of unused memory

### 🧮 Recommended zram Sizes

| System RAM | Recommended zram Size | Notes                                                     |
|------------|----------------------|-----------------------------------------------------------|
| **8 GB**   | 2× RAM (≈16 GB)      | Greatly improves responsiveness and multitasking          |
| **16 GB**  | 1× RAM (≈16 GB)      | Balanced setup for most users                             |
| **32 GB**  | 0.5× RAM (≈16 GB)    | Enough for compression efficiency; disk swap rarely used  |

**Summary:**
- ≤ 8 GB RAM → heavier zram helps a lot
- ≥ 16 GB RAM → moderate settings
- ≥ 32 GB RAM → small zram, mostly for efficiency

### 🧰 Enabling zram (Manual Example)

```bash
sudo modprobe zram
echo lz4 | sudo tee /sys/block/zram0/comp_algorithm
echo 8G | sudo tee /sys/block/zram0/disksize
sudo mkswap /dev/zram0
sudo swapon /dev/zram0
```

---

## 📝 Notes

- Always backup important data before making system changes
- Test commands in a safe environment first
- Review scripts before running them with sudo privileges
- Keep your system updated regularly for security patches