#update-all-icon-caches.sh
#!/bin/bash
# Force update icon cache for all icon themes in /usr/share/icons (verbose, ignore errors)

for dir in /usr/share/icons/*; do
  if [ -d "$dir" ]; then
    echo "Updating icon cache in: $dir"
    sudo gtk-update-icon-cache -f -v "$dir" 2>/dev/null || true
  fi
done

echo "All icon caches updated."

