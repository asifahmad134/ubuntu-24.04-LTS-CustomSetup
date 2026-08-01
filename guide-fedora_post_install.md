# 🆕 Clean & Minimal Fedora — Post-Install Setup Guide

## 💻 System Info & Useful Commands

```bash
# Display hostname and key system info
cat /etc/fedora-release
hostnamectl
rpm -E %fedora
sudo dmidecode -s bios-version

# Show disk usage — sorted largest first
du -h -s * | sort -h -r
```

## ⭐ Update, Upgrade, Fixes

```bash
echo 'fastestmirror=True' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf

sudo dnf group list
sudo dnf group info development-tools
sudo dnf group info c-development

sudo dnf upgrade --refresh
sudo dnf search <package>
sudo dnf autoremove
sudo dnf clean all
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

# ✴️ Suggested & Optional Packages

## 🛸 Enable RPM Fusion

```bash
sudo dnf install \
https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

### Essential Tools

```bash
sudo dnf install git curl thunar adb fastboot foliate file-roller unrar
sudo dnf install gnome-tweaks gnome-extensions-app
sudo dnf install transmission-gtk wike
sudo dnf install gapless clapper
```

## 🧹 Remove Old Kernels

```bash
rpm -qa kernel\*
dnf repoquery --installonly
sudo dnf remove kernel-<version>
```

## 🌐 Install Google Chrome

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf install ./google-chrome-stable_current_x86_64.rpm
```

## 🎴 Install Node.js / 📦 Global NPM Package

```bash
# Fedora ships current Node versions.
sudo dnf install nodejs
# Specific version (example):
sudo dnf install nodejs24

sudo npm install -g npm@latest corepack@latest npm-check-updates typescript pnpm@latest yarn vite
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

```bash
sudo bash -c "$(curl -s https://ohmyposh.dev/install.sh)" -- -d /usr/bin

# Move themes to home directory
sudo mv /root/.cache/oh-my-posh/themes/ ~/.oh-my-posh
sudo chown -R $USER:$USER ~/.oh-my-posh

# Use the enclosed `.bashrc` — uncomment your preferred theme at the bottom, then refresh:
exec bash
```
