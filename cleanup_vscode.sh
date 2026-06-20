#!/bin/bash

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to get file size in bytes
get_size_bytes() {
    local file="$1"
    if [ -e "$file" ]; then
        stat -c %s "$file" 2>/dev/null || echo 0
    else
        echo 0
    fi
}

# Function to convert bytes to MiB (1 MiB = 1048576 bytes)
bytes_to_mib() {
    local bytes="$1"
    echo "scale=2; $bytes / 1048576" | bc
}

# Initialize total saved bytes
total_saved_bytes=0

echo -e "${YELLOW}Starting VS Code cleanup...${NC}"

# 1. Remove ThirdPartyNotices.txt, LICENSES.chromium.html, LICENSE.rtf
files_to_remove_1=(
    "/usr/share/code/resources/app/ThirdPartyNotices.txt"
    "/usr/share/code/LICENSES.chromium.html"
    "/usr/share/code/resources/app/LICENSE.rtf"
)

for file in "${files_to_remove_1[@]}"; do
    if [ -e "$file" ]; then
        size=$(get_size_bytes "$file")
        size_mib=$(bytes_to_mib "$size")
        echo -e "Removing: ${file} (${size_mib} MiB)"
        sudo rm "$file"
        total_saved_bytes=$((total_saved_bytes + size))
    else
        echo -e "${RED}Not found: ${file}${NC}"
    fi
done

# 2. Remove all locale files except en-GB.pak and en-US.pak
# Note: The original command uses bash extended globbing. We need to enable it.
shopt -s extglob

locale_dir="/usr/share/code/locales"
if [ -d "$locale_dir" ]; then
    # List files matching the pattern
    # We iterate over the files that match the exclusion pattern
    for file in "$locale_dir"/!("en-GB.pak"|"en-US.pak"); do
        if [ -e "$file" ]; then
            size=$(get_size_bytes "$file")
            size_mib=$(bytes_to_mib "$size")
            echo -e "Removing: ${file} (${size_mib} MiB)"
            sudo rm -f "$file"
            total_saved_bytes=$((total_saved_bytes + size))
        fi
    done
else
    echo -e "${RED}Directory not found: ${locale_dir}${NC}"
fi

# 3. Remove the licenses directory
licenses_dir="/usr/share/code/resources/app/licenses"
if [ -d "$licenses_dir" ]; then
    # Calculate size of the directory before removal
    # Use du to get the total size of the directory in bytes
    dir_size=$(du -sb "$licenses_dir" 2>/dev/null | awk '{print $1}')
    if [ -n "$dir_size" ] && [ "$dir_size" -gt 0 ]; then
        size_mib=$(bytes_to_mib "$dir_size")
        echo -e "Removing: ${licenses_dir} (${size_mib} MiB)"
        sudo rm -rf "$licenses_dir"
        total_saved_bytes=$((total_saved_bytes + dir_size))
    else
        echo -e "${RED}Directory empty or not accessible: ${licenses_dir}${NC}"
    fi
else
    echo -e "${RED}Directory not found: ${licenses_dir}${NC}"
fi

# Display total saved
total_saved_mib=$(bytes_to_mib "$total_saved_bytes")

echo -e "${GREEN}Cleanup complete! Total space saved: ${total_saved_mib} MiB${NC}"

