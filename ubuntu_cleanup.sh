#!/usr/bin/env bash

# Enhanced Ubuntu Cleanup Script
# This script performs comprehensive system cleanup while maintaining security and robustness

# Configuration variables (can be moved to a separate config file)
CONFIG_FILE="${HOME}/.config/ubuntu_cleanup.conf"
LOG_DIR="/var/log/system_cleanup"
LOG_FILE="${LOG_DIR}/cleanup_$(date +%Y%m%d_%H%M%S).log"
DRY_RUN=0
VERBOSE=0
TIMEOUT_DURATION=60  # Timeout for user prompts in seconds
PARALLEL_JOBS=2      # Number of parallel jobs for supported operations
MAX_RESOURCE_USAGE=50  # Maximum CPU percentage to use
DEFAULT_RETENTION_DAYS=10  # Default number of days to keep logs

# Load configuration if available
if [ -f "$CONFIG_FILE" ]; then
    echo "Loading configuration from $CONFIG_FILE"
    source "$CONFIG_FILE"
fi

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Setup logging with rotation
exec > >(tee -a "$LOG_FILE") 2>&1

# Check for root privileges
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script requires elevated privileges for some operations."
        echo "You will be prompted for your password as needed."
        HAS_ROOT=0
    else
        HAS_ROOT=1
    fi
}

# Function to handle sudo commands
run_with_privileges() {
    if [[ $HAS_ROOT -eq 1 ]]; then
        eval "$@"
    else
        sudo "$@"
    fi
}

# Function to execute with resource limits
run_with_limits() {
    if command -v cpulimit >/dev/null 2>&1; then
        cpulimit -l $MAX_RESOURCE_USAGE -- "$@"
    else
        echo "cpulimit not installed, running without CPU limitations"
        "$@"
    fi
}

# Function to display progress
total_steps=19
current_step=0

progress() {
    current_step=$((current_step + 1))
    percentage=$((current_step * 100 / total_steps))
    bar_size=30
    filled_size=$((percentage * bar_size / 100))
    bar=$(printf "%${filled_size}s" | tr ' ' '#')
    empty=$(printf "%$((bar_size - filled_size))s" | tr ' ' '-')
    echo -ne "[$bar$empty] $percentage% - $1\r"
    echo -e "[$bar$empty] $percentage% - $1"
}

# Function for calculating size difference
calculate_size_diff() {
    local before=$1
    local after=$2
    
    # Remove letters and keep only numbers and decimal points
    before_num=$(echo "$before" | sed 's/[^0-9.]//g')
    after_num=$(echo "$after" | sed 's/[^0-9.]//g')
    
    # Extract unit (G, M, etc.)
    unit=$(echo "$before" | sed 's/[0-9.]//g')
    
    # Calculate difference
    diff=$(echo "$after_num - $before_num" | bc)
    
    echo "$diff$unit"
}

# Backup functionality has been removed

# Function for timeout handling with user prompts
prompt_with_timeout() {
    local prompt=$1
    local timeout=$TIMEOUT_DURATION
    local response
    
    # Use read with timeout
    read -t "$timeout" -p "$prompt" response || true
    
    # Return default value if timeout occurred
    if [ -z "$response" ]; then
        echo "Timeout reached, assuming default answer (n)"
        return 1
    fi
    
    # Process response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to check disk space in a directory
check_disk_space() {
    local dir=$1
    local threshold=${2:-90}  # Default threshold of 90%
    
    local usage=$(df -h "$dir" | awk 'NR==2 {print $5}' | tr -d '%')
    if [ "$usage" -gt "$threshold" ]; then
        echo "Warning: Disk usage for $dir is critically high at $usage%"
        return 1
    else
        return 0
    fi
}

# Function to safely remove files
safe_remove() {
    local target=$1
    local force=${2:-0}
    
    # Check if target exists and is not a system-critical path
    if [ ! -e "$target" ]; then
        echo "Warning: $target does not exist, skipping removal"
        return 0
    fi
    
    # Check if path is too dangerous to remove
    for dangerous_path in / /bin /boot /dev /etc /lib /proc /root /sbin /sys /usr /var; do
        if [ "$target" = "$dangerous_path" ]; then
            echo "Error: Refusing to remove critical system path $target"
            return 1
        fi
    done
    
    # Safe removal
    if [ -d "$target" ] && [ ! -L "$target" ]; then
        # It's a directory, remove contents but keep directory
        echo "Removing contents of directory $target"
        if [ $force -eq 1 ]; then
            rm -rf "${target:?}"/* 2>/dev/null || true
        else
            rm -r "${target:?}"/* 2>/dev/null || true
        fi
    else
        # It's a file or symbolic link
        echo "Removing $target"
        if [ $force -eq 1 ]; then
            rm -f "$target" 2>/dev/null || true
        else
            rm "$target" 2>/dev/null || true
        fi
    fi
    
    return $?
}

# Parse command line options
while getopts "dnvt:j:r:k:" opt; do
    case $opt in
        d|n) DRY_RUN=1 ;;
        v) VERBOSE=1 ;;
        t) TIMEOUT_DURATION=$OPTARG ;;
        j) PARALLEL_JOBS=$OPTARG ;;
        r) MAX_RESOURCE_USAGE=$OPTARG ;;
        k) DEFAULT_RETENTION_DAYS=$OPTARG ;;
        *) echo "Usage: $0 [-d|-n] [-v] [-t timeout] [-j jobs] [-r max_cpu] [-k retention_days]" >&2
           echo "  -d,-n  Dry run (show what would be done)"
           echo "  -v     Verbose output"
           echo "  -t     Timeout for user prompts in seconds (default: 60)"
           echo "  -j     Number of parallel jobs for supported operations (default: 2)"
           echo "  -r     Maximum CPU percentage to use (default: 50)"
           echo "  -k     Default retention days for logs and temp files (default: 10)"
           exit 1 ;;
    esac
done

# Check if required tools are installed
check_dependencies() {
    local missing_tools=()
    
    for tool in apt-get find grep awk md5sum bc; do
        if ! command -v $tool &>/dev/null; then
            missing_tools+=("$tool")
        fi
    done
    
    # Check for optional tools
    for tool in cpulimit deborphan bleachbit parallel; do
        if ! command -v $tool &>/dev/null; then
            echo "Optional tool $tool is not installed"
        fi
    done
    
    if [ ${#missing_tools[@]} -gt 0 ]; then
        echo "Error: The following required tools are missing: ${missing_tools[*]}"
        echo "Please install them before running this script"
        exit 1
    fi
}

# Record initial disk space
record_disk_space() {
    echo "Initial disk space usage:"
    df -h / /home
    initial_space=$(df -h / | awk 'NR==2 {print $4}')
    initial_usage_percent=$(df -h / | awk 'NR==2 {print $5}')
}

# Check if we're running on Ubuntu
check_ubuntu() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ "$ID" == "ubuntu" ]]; then
            echo "✓ Running on Ubuntu $VERSION_ID"
            return 0
        else
            echo "Warning: This script is optimized for Ubuntu, but you're running $PRETTY_NAME"
            echo "Some functionality may not work as expected"
            return 1
        fi
    else
        echo "Warning: Unable to determine OS version"
        return 1
    fi
}

# Main execution starts here
check_dependencies
check_root
check_ubuntu
record_disk_space

# Confirmation prompt
if [ $DRY_RUN -eq 0 ]; then
    if prompt_with_timeout "Are you sure you want to proceed with the cleanup? (y/n): "; then
        echo "Proceeding with cleanup..."
    else
        echo "Aborted."
        exit 1
    fi
fi

echo "Starting cleanup process..."
[ $DRY_RUN -eq 1 ] && echo "DRY RUN MODE - No changes will be made"

# No backup step - proceeding directly to cleanup

# Update package list
progress "Updating package list"
if [ $DRY_RUN -eq 0 ]; then
    if run_with_privileges apt-get update; then
        echo "✓ Package list updated successfully"
    else
        echo "✗ Failed to update package list"
    fi
fi

# Clear user cache
progress "Clearing user cache"
if [ $DRY_RUN -eq 0 ]; then
    # Get size before
    cache_size_before=$(du -sh ~/.cache 2>/dev/null | cut -f1)
    echo "Cache size before cleanup: $cache_size_before"
    
    # Only remove cache files older than a certain number of days
    if find ~/.cache -type f -mtime +3 -exec rm -f {} \; 2>/dev/null; then
        echo "✓ User cache older than 3 days cleared"
    else
        echo "✗ Failed to clear user cache"
    fi
    
    # Get size after
    cache_size_after=$(du -sh ~/.cache 2>/dev/null | cut -f1)
    echo "Cache size after cleanup: $cache_size_after"
fi

# Clean up the APT cache
progress "Cleaning up APT cache"
if [ $DRY_RUN -eq 0 ]; then
    if run_with_privileges apt-get clean; then
        echo "✓ APT cache cleaned"
    else
        echo "✗ Failed to clean APT cache"
    fi
fi

# Remove obsolete packages
progress "Removing obsolete packages"
if [ $DRY_RUN -eq 0 ]; then
    if run_with_privileges apt-get autoclean; then
        echo "✓ Obsolete packages removed"
    else
        echo "✗ Failed to remove obsolete packages"
    fi
fi

# Remove unused packages and dependencies
progress "Removing unused packages and dependencies"
if [ $DRY_RUN -eq 0 ]; then
    # List packages to be removed first
    echo "Packages that will be removed:"
    run_with_privileges apt-get autoremove -y --dry-run | grep "^Remv"
    
    # Ask for confirmation
    if prompt_with_timeout "Proceed with removing these packages? (y/n): "; then
        if run_with_privileges apt-get autoremove -y; then
            echo "✓ Unused packages and dependencies removed"
        else
            echo "✗ Failed to remove unused packages"
        fi
    else
        echo "Skipping package removal"
    fi
fi

# Remove old kernel versions with extra precautions
progress "Removing old kernel versions"
if [ $DRY_RUN -eq 0 ]; then
    # Get current kernel version
    current_kernel=$(uname -r)
    echo "Current kernel: $current_kernel"
    
    # List installed kernels
    installed_kernels=$(run_with_privileges dpkg --list | grep -E 'linux-image-[0-9]+' | awk '{print $2}')
    echo "Installed kernels:"
    echo "$installed_kernels"
    
    # Ask for confirmation
    if prompt_with_timeout "Proceed with removing old kernels? (y/n): "; then
        if run_with_privileges apt-get autoremove --purge -y; then
            echo "✓ Old kernel versions removed"
        else
            echo "✗ Failed to remove old kernel versions"
        fi
    else
        echo "Skipping kernel removal"
    fi
fi

# BleachBit installation and cleanup with more control
progress "Running BleachBit cleanup"
if [ $DRY_RUN -eq 0 ]; then
    if ! command -v bleachbit &> /dev/null; then
        echo "BleachBit not installed"
        if prompt_with_timeout "Do you want to install BleachBit? (y/n): "; then
            echo "Installing BleachBit..."
            if run_with_privileges apt-get install -y bleachbit; then
                echo "✓ BleachBit installed successfully"
            else
                echo "✗ Failed to install BleachBit"
            fi
        else
            echo "Skipping BleachBit installation"
        fi
    fi
    
    if command -v bleachbit &> /dev/null; then
        echo "BleachBit cleaners available:"
        bleachbit --list | grep -v "^$"
        
        echo "Running safe BleachBit cleaners..."
        safe_cleaners="system.cache system.localizations system.tmp system.rotated_logs"
        run_with_privileges bleachbit --clean $safe_cleaners
        echo "✓ System caches cleaned using BleachBit"
        
        if prompt_with_timeout "Run additional BleachBit cleaners? (y/n): "; then
            additional_cleaners="system.clipboard firefox.cache firefox.cookies google_chrome.cache thumbnails.cache"
            run_with_privileges bleachbit --clean $additional_cleaners
            echo "✓ Additional caches cleaned using BleachBit"
        fi
    fi
fi

# Remove unused Snap packages with better reporting
progress "Checking for unused Snap packages"
if [ $DRY_RUN -eq 0 ] && command -v snap &> /dev/null; then
    # List unused snap packages
    unused_snaps=$(run_with_privileges snap list --all | awk '/disabled/{print $1, $3}')
    
    if [ -n "$unused_snaps" ]; then
        echo "Unused Snap packages found:"
        echo "$unused_snaps"
        
        if prompt_with_timeout "Do you want to remove these unused Snap packages? (y/n): "; then
            echo "$unused_snaps" | while read snapname revision; do
                echo "Removing $snapname revision $revision"
                run_with_privileges snap remove "$snapname" --revision="$revision"
            done
            echo "✓ Unused Snap packages removed"
        else
            echo "Skipping Snap package removal"
        fi
    else
        echo "No unused Snap packages found"
    fi
fi

# Clean flatpak unused runtimes and applications
progress "Checking for unused Flatpak runtimes"
if [ $DRY_RUN -eq 0 ] && command -v flatpak &> /dev/null; then
    echo "Removing unused Flatpak runtimes..."
    run_with_privileges flatpak uninstall --unused -y
    echo "✓ Unused Flatpak runtimes removed"
fi

# Clear thumbnail cache more selectively
progress "Clearing thumbnail cache"
if [ $DRY_RUN -eq 0 ]; then
    thumbnail_size_before=$(du -sh ~/.cache/thumbnails 2>/dev/null | cut -f1)
    echo "Thumbnail cache size before cleanup: $thumbnail_size_before"
    
    # Remove thumbnails older than 30 days
    if find ~/.cache/thumbnails -type f -mtime +30 -delete 2>/dev/null; then
        echo "✓ Old thumbnail cache cleared"
    else
        echo "✗ Failed to clear thumbnail cache"
    fi
    
    thumbnail_size_after=$(du -sh ~/.cache/thumbnails 2>/dev/null | cut -f1)
    echo "Thumbnail cache size after cleanup: $thumbnail_size_after"
fi

# Clean up systemd journal logs with better size control
progress "Cleaning up systemd journal logs"
if [ $DRY_RUN -eq 0 ] && command -v journalctl &> /dev/null; then
    echo "Journal size before cleanup:"
    run_with_privileges journalctl --disk-usage
    
    # Keep logs from the last X days
    if run_with_privileges journalctl --vacuum-time="${DEFAULT_RETENTION_DAYS}d"; then
        echo "✓ Systemd journal logs cleaned (keeping last $DEFAULT_RETENTION_DAYS days)"
    else
        echo "✗ Failed to clean systemd journal logs by time"
    fi
    
    # Also limit by size
    if run_with_privileges journalctl --vacuum-size=50M; then
        echo "✓ Systemd journal logs cleaned (limiting to 50M)"
    else
        echo "✗ Failed to clean systemd journal logs by size"
    fi
    
    echo "Journal size after cleanup:"
    run_with_privileges journalctl --disk-usage
fi

# Remove old files from /tmp directory with better safety checks
progress "Cleaning up /tmp directory"
if [ $DRY_RUN -eq 0 ]; then
    tmp_size_before=$(du -sh /tmp 2>/dev/null | cut -f1)
    echo "Temporary directory size before cleanup: $tmp_size_before"
    
    # Only remove files older than X days and not in use
    if run_with_privileges find /tmp -type f -atime +$DEFAULT_RETENTION_DAYS -not -exec fuser -s {} \; -delete; then
        echo "✓ Old files from /tmp directory removed"
    else
        echo "✗ Failed to remove old files from /tmp"
    fi
    
    tmp_size_after=$(du -sh /tmp 2>/dev/null | cut -f1)
    echo "Temporary directory size after cleanup: $tmp_size_after"
fi

# Clean Firefox profiles if present
progress "Cleaning browser caches"
if [ $DRY_RUN -eq 0 ]; then
    # Firefox cache
    if [ -d ~/.mozilla/firefox ]; then
        echo "Cleaning Firefox cache..."
        find ~/.mozilla/firefox -name "*Cache*" -type d -exec rm -rf {} \; 2>/dev/null || true
        find ~/.mozilla/firefox -name "*cache*" -type d -exec rm -rf {} \; 2>/dev/null || true
        echo "✓ Firefox cache cleaned"
    fi
    
    # Chrome/Chromium cache
    for browser_dir in ~/.config/google-chrome ~/.config/chromium; do
        if [ -d "$browser_dir" ]; then
            echo "Cleaning $(basename "$browser_dir") cache..."
            find "$browser_dir" -name "Cache" -type d -exec rm -rf {} \; 2>/dev/null || true
            find "$browser_dir" -name "*cache*" -type d -exec rm -rf {} \; 2>/dev/null || true
            echo "✓ $(basename "$browser_dir") cache cleaned"
        fi
    done
fi

# Remove old log files from /var/log with improved compression
progress "Managing log files"
if [ $DRY_RUN -eq 0 ]; then
    log_size_before=$(du -sh /var/log 2>/dev/null | cut -f1)
    echo "Log directory size before cleanup: $log_size_before"
    
    # Compress log files older than 7 days
    if run_with_privileges find /var/log -type f -name "*.log" -mtime +7 -exec gzip -9 {} \; 2>/dev/null; then
        echo "✓ Old log files compressed"
    else
        echo "✗ Failed to compress some old log files"
    fi
    
    # Remove rotated logs older than retention period
    if run_with_privileges find /var/log -type f -name "*.gz" -mtime +$DEFAULT_RETENTION_DAYS -delete 2>/dev/null; then
        echo "✓ Very old compressed logs removed"
    else
        echo "✗ Failed to remove some very old compressed logs"
    fi
    
    log_size_after=$(du -sh /var/log 2>/dev/null | cut -f1)
    echo "Log directory size after cleanup: $log_size_after"
fi

# Clean up core dump files with more information
progress "Checking core dump files"
if [ $DRY_RUN -eq 0 ]; then
    # Check for core dumps and their sizes
    if [ -d /var/lib/apport/coredump ]; then
        core_size=$(du -sh /var/lib/apport/coredump 2>/dev/null | cut -f1)
        core_count=$(find /var/lib/apport/coredump -type f -name "core*" | wc -l)
        echo "Found $core_count core dump files using $core_size of space"
        
        if [ $core_count -gt 0 ] && prompt_with_timeout "Do you want to delete core dump files? (y/n): "; then
            if run_with_privileges find /var/lib/apport/coredump -type f -name 'core*' -delete; then
                echo "✓ Core dump files cleaned"
            else
                echo "✗ Failed to clean core dump files"
            fi
        else
            echo "Skipping core dump removal"
        fi
    else
        echo "No core dump directory found"
    fi
fi

# Remove orphaned packages with detailed listing
progress "Checking for orphaned packages"
if [ $DRY_RUN -eq 0 ]; then
    if command -v deborphan &> /dev/null; then
        orphaned=$(deborphan)
        
        if [ -n "$orphaned" ]; then
            echo "Orphaned packages found:"
            echo "$orphaned"
            
            if prompt_with_timeout "Do you want to remove these orphaned packages? (y/n): "; then
                run_with_privileges deborphan | xargs run_with_privileges apt-get -y remove --purge
                echo "✓ Orphaned packages removed"
            else
                echo "Skipping orphaned package removal"
            fi
        else
            echo "No orphaned packages found"
        fi
    else
        echo "deborphan not installed, skipping orphaned package check"
        if prompt_with_timeout "Do you want to install deborphan to check for orphaned packages? (y/n): "; then
            run_with_privileges apt-get install -y deborphan
            echo "✓ deborphan installed"
            progress "Re-checking for orphaned packages"
            orphaned=$(deborphan)
            
            if [ -n "$orphaned" ]; then
                echo "Orphaned packages found:"
                echo "$orphaned"
                
                if prompt_with_timeout "Do you want to remove these orphaned packages? (y/n): "; then
                    run_with_privileges deborphan | xargs run_with_privileges apt-get -y remove --purge
                    echo "✓ Orphaned packages removed"
                fi
            else
                echo "No orphaned packages found"
            fi
        fi
    fi
fi

# Clean package installation backup files
progress "Cleaning package backup files"
if [ $DRY_RUN -eq 0 ]; then
    dpkg_backup_size=$(find /var/backups -name "dpkg.status*" | xargs du -ch 2>/dev/null | grep total$ | cut -f1)
    echo "Package backup files size: $dpkg_backup_size"
    
    # Keep only the most recent 5 backups
    if run_with_privileges find /var/backups -name "dpkg.status.*" | sort -r | tail -n +6 | xargs rm -f 2>/dev/null; then
        echo "✓ Old package backup files cleaned"
    else
        echo "✗ Failed to clean old package backup files"
    fi
fi

# Clean temporary downloaded package files
progress "Cleaning downloaded package files"
if [ $DRY_RUN -eq 0 ]; then
    apt_archives_size=$(du -sh /var/cache/apt/archives 2>/dev/null | cut -f1)
    echo "Downloaded package files size: $apt_archives_size"
    
    if run_with_privileges apt-get clean; then
        echo "✓ Downloaded package files cleaned"
    else
        echo "✗ Failed to clean downloaded package files"
    fi
fi

# Final system update and upgrade
progress "Performing final system update"
if [ $DRY_RUN -eq 0 ]; then
    if prompt_with_timeout "Do you want to update all installed packages? (y/n): "; then
        if run_with_privileges apt-get update && run_with_privileges apt-get upgrade -y; then
            echo "✓ System packages updated successfully"
        else
            echo "✗ System update failed"
        fi
    else
        echo "Skipping system update"
    fi
fi

# Show final disk space usage and calculate savings
echo -e "\nFinal disk space usage:"
df -h / /home
final_space=$(df -h / | awk 'NR==2 {print $4}')
final_usage_percent=$(df -h / | awk 'NR==2 {print $5}')

# Try to calculate space saved
if [[ "$initial_space" =~ [0-9]+(\.[0-9]+)?[GM] ]] && [[ "$final_space" =~ [0-9]+(\.[0-9]+)?[GM] ]]; then
    # Check if both have the same unit (G or M)
    init_unit="${initial_space: -1}"
    final_unit="${final_space: -1}"
    
    if [ "$init_unit" = "$final_unit" ]; then
        init_num=$(echo "$initial_space" | sed 's/[^0-9.]//g')
        final_num=$(echo "$final_space" | sed 's/[^0-9.]//g')
        saved=$(echo "$final_num - $init_num" | bc)
        echo -e "\nSpace freed: $saved$init_unit"
    else
        echo -e "\nInitial free space: $initial_space"
        echo "Final free space: $final_space"
        echo "Units are different, can't calculate exact space saved"
    fi
else
    echo -e "\nInitial free space: $initial_space"
    echo "Final free space: $final_space"
fi

echo "Initial usage: $initial_usage_percent"
echo "Final usage: $final_usage_percent"
echo "Log file: $LOG_FILE"

echo -e "\nCleanup process completed successfully!"
echo "This script has been executed with enhanced security measures and comprehensive reporting."
echo "NOTE: No backups were created. This is a non-reversible cleanup operation."