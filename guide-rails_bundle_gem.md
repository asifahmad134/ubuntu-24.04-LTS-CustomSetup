# Rails 8+ & Bundler Cheat Sheet

## 🎨 Add Tailwind CSS
Rails 8+ uses the `tailwindcss-rails` gem with a standalone executable (no Node.js required).

```bash
# Add Tailwind gem to your Gemfile
bundle add tailwindcss-rails

# Install configuration, bin/dev, and Procfile.dev
bin/rails tailwindcss:install

# Start the local development server (runs Rails + Tailwind watcher)
bin/dev
```

---

## ⚡ System & Performance Setup
Speed up gem installations and keep system tools up-to-date.

```bash
# Update RubyGems & Bundler
gem update --system
gem update bundler

# Speed up gem installs with parallel workers
bundle config set --global jobs 4

# Display detailed environment info
bundle env
```

---

## 📦 Gem Management & Updates

### Inspect Gems
```bash
# List all gems in the current bundle
bundle list

# Check for available gem updates
bundle outdated

# Check outdated gems by specific group
bundle outdated --group development
```

### Update Gems
```bash
# Update all gems within Gemfile constraints
bundle update

# Update specific gem(s)
bundle update rails
bundle update rails devise puma
```

### Maintenance & Cleanup
```bash
# Verify dependencies and check lockfile status
bundle check

# Clean up unused/orphaned gems
bundle clean

# Force removal of unused gems
bundle clean --force
```
