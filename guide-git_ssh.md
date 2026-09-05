# 📜 Git & SSH Setup

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
