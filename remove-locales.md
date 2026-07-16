## ⚛️ Remove Language Locales (~50+ MB saved per app)

Removes unused locale files from Chromium-based apps. Only English variants are kept.

### Google Chrome

```bash
sudo rm /opt/google/chrome/locales/!("en-GB.pak"|"en-US.pak")
```

### VS Code

```bash
sudo rm /usr/share/code/locales/!("en-GB.pak"|"en-US.pak")
sudo rm /usr/share/code/resources/app/ThirdPartyNotices.txt \
        /usr/share/code/LICENSES.chromium.html \
        /usr/share/code/resources/app/LICENSE.rtf
sudo rm -fdr /usr/share/code/resources/app/licenses
```

### antigravity

```bash
sudo rm /usr/share/antigravity/locales/!("en-GB.pak"|"en-US.pak")
sudo rm /usr/share/antigravity/resources/app/ThirdPartyNotices.txt \
        /usr/share/antigravity/LICENSES.chromium.html \
        /usr/share/antigravity/resources/app/LICENSE.txt
```

### Cursor

```bash
sudo rm /usr/share/cursor/locales/!("en-GB.pak"|"en-US.pak")
sudo rm /usr/share/cursor/resources/app/ThirdPartyNotices.txt \
        /usr/share/cursor/LICENSES.chromium.html \
        /usr/share/cursor/resources/app/LICENSE.txt
```

### LM Studio

```bash
sudo rm /opt/LM-Studio/locales/!("en-GB.pak"|"en-US.pak")
sudo rm /opt/LM-Studio/LICENSE.electron.txt /opt/LM-Studio/LICENSES.chromium.html
```

### Slack

```bash
sudo rm /usr/lib/slack/locales/!("en-GB.pak"|"en-US.pak")
sudo rm /usr/lib/slack/LICENSE \
        /usr/lib/slack/resources/LICENSES.chromium.html \
        /usr/lib/slack/LICENSES-linux.json
```

### Brave Browser

```bash
sudo rm /opt/brave.com/brave/locales/!("en-GB.pak"|"en-US.pak")
```

### Obsidian

```bash
sudo rm /opt/Obsidian/locales/!("en-GB.pak"|"en-US.pak")
sudo rm /opt/Obsidian/LICENSES.chromium.html /opt/Obsidian/LICENSE.electron.txt
```

### GitKraken

```bash
sudo rm /usr/share/gitkraken/locales/!("en-GB.pak"|"en-US.pak")
sudo rm /usr/share/gitkraken/LICENSES.chromium.html /usr/share/gitkraken/LICENSE.electron
```

### Joplin

```bash
sudo rm /opt/Joplin/locales/!("en-GB.pak"|"en-US.pak")
sudo rm /opt/Joplin/LICENSES.chromium.html /opt/Joplin/LICENSE.electron.txt
```

### FreeTube

```bash
sudo rm /opt/FreeTube/locales/!("en-GB.pak"|"en-US.pak")
sudo rm /opt/FreeTube/LICENSES.chromium.html /opt/FreeTube/LICENSE.electron.txt
```

### Super Productivity

```bash
sudo rm /opt/Super\ Productivity/locales/!("en-GB.pak"|"en-US.pak")
sudo rm /opt/Super\ Productivity/LICENSES.chromium.html \
        /opt/Super\ Productivity/LICENSE.electron.txt
```

### ONLYOFFICE

```bash
sudo rm /opt/onlyoffice/desktopeditors/locales/!("en-US.pak")
sudo rm -rf /opt/onlyoffice/desktopeditors/converter/empty/!("en-US"|"default")
sudo rm -rf /opt/onlyoffice/desktopeditors/converter/templates/!("EN")
sudo rm -rf /opt/onlyoffice/desktopeditors/dictionaries/!("en_US")
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
