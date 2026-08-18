# Install to /opt guide

## zed
```bash
sudo tar -xvf zed-linux-x86_64.tar.gz -C /opt
sudo ln -sf /opt/zed.app/bin/zed /usr/bin/zed
sudo cp /opt/zed.app/share/applications/dev.zed.Zed.desktop /usr/share/applications/
sudo sed -i "s|Icon=zed|Icon=/opt/zed.app/share/icons/hicolor/512x512/apps/zed.png|g" /usr/share/applications/dev.zed.Zed.desktop
```
## firefox
```bash
sudo tar -xJf firefox-*.tar.xz -C /opt
sudo ln -sf /opt/firefox/firefox /usr/local/bin/firefox
sudo wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop -P /usr/local/share/applications
```

