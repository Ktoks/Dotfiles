#!/usr/bin/env bash
# ==============================================================================
# POP!_OS 26.04 HIGH-PERFORMANCE WORKSTATION OPTIMIZATION SCRIPT (CORRECTED)
# ==============================================================================

set -euo pipefail

echo "=== 1. Disabling and Masking Unnecessary Services ==="
# Stops snapd, error reporting, rsyslog, and system updater services safely
# (Preserves wpa_supplicant to maintain Wi-Fi capability)
sudo systemctl disable --now \
  snapd.service \
  snapd.socket \
  snapd.apparmor.service \
  apport.service \
  rsyslog.service \
  ModemManager.service \
  com.system76.SystemUpdater.service 2>/dev/null || true

sudo systemctl mask --now \
  snapd.service \
  snapd.socket \
  com.system76.SystemUpdater.service 2>/dev/null || true

echo "=== 2. Disabling Automated Package Timers ==="
# Stops unexpected apt actions while working
sudo systemctl disable --now apt-daily.timer apt-daily-upgrade.timer
sudo systemctl mask --now apt-daily.timer apt-daily-upgrade.timer

echo "=== 3. Writing Advanced Memory Profile (High-RAM Workstation) ==="
# Optimizes NVMe caches, virtual dirt thresholds, and minimizes aggressive swapping
sudo tee /etc/sysctl.d/99-custom-performance.conf > /dev/null << 'EOF'
# Keep active data in physical RAM; swap only under extreme memory pressure
vm.swappiness = 1

# Maximize filesystem metadata (dentry/inode) retention in RAM
vm.vfs_cache_pressure = 10

# Disable percentage-based dirty ratios in favor of explicit byte limits
vm.dirty_ratio = 0
vm.dirty_background_ratio = 0

# Start background NVMe writes as soon as 256 MB of dirty data accumulates
vm.dirty_background_bytes = 268435456

# Block process I/O only if unwritten dirty data reaches 2 GB (prevents write stalls)
vm.dirty_bytes = 2147483648
EOF

# Apply memory tuning instantly
sudo sysctl --system

echo "=== 4. Neutralizing zRAM & Disabling Active Swap ==="
# Stops unnecessary CPU overhead for RAM compression and turns off active swap
sudo systemctl disable --now pop-default-settings-zram.service 2>/dev/null || true
sudo swapoff -a

echo "=== 5. Hiding Desktop Autostart Bloat ==="
# Safely hides bloat desktop entries in user config without breaking D-Bus accessibility
mkdir -p ~/.config/autostart

for file in \
  geoclue-demo-agent.desktop \
  orca-autostart.desktop \
  com.system76.CosmicInitialSetup.desktop \
  im-launch.desktop \
  pop-app-folders.desktop \
  pop-flatpak-repos.desktop; do
    if [ -f "/etc/xdg/autostart/$file" ]; then
        cp /etc/xdg/autostart/"$file" ~/.config/autostart/
        echo "Hidden=true" >> ~/.config/autostart/"$file"
        echo "X-COSMIC-Autostart-enabled=false" >> ~/.config/autostart/"$file"
    fi
done

echo "=============================================================================="
# REMINDER:
# Verify your manually edited system files if needed:
# sudo hx /etc/systemd/journald.conf /etc/crypttab /etc/fstab
echo "Optimization workflow complete!"
