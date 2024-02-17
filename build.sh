#!/bin/bash

set -e

# Initialize repo with specified manifest
 repo init -u https://github.com/LineageOS/android.git -b lineage-20.0 --git-lfs

# Run inside foss.crave.io devspace, in the project folder
# Remove existing local_manifests
crave run --no-patch -- "rm -rf .repo/local_manifests && \
# Initialize repo with specified manifest
repo init -u https://github.com/AfterLifePrjkt13/android_manifest.git -b LTS --depth 1 -g default,-mips,-darwin,-notdefault ;\

# Clone local_manifests repository
git clone https://github.com/eurekadevelopment/local_manifests --depth 1 -b android-13 .repo/local_manifests ;\

# Removals

# Sync the repositories
repo sync -c -j$(nproc --all) --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync && \


# Set up build environment
export ALLOW_MISSING_DEPENDENCIES=true ; \
source build/envsetup.sh && \

# Lunch configuration
lunch afterlife_a10-userdebug ;\

croot ;\
m afterlife ; \
echo "Date and time:" ; \

# Print out/build_date.txt
cat out/build_date.txt; \

# Print SHA256
sha256sum out/target/product/*/*.zip"

# Clean up
rm -rf a10/*



# Pull generated zip files
crave pull out/target/product/*/*.zip 

# Pull generated img files
crave pull out/target/product/*/*.img

# Upload zips to Telegram
telegram-upload --to raospr a10/*.zip

#Upload to Github Releases
#curl -sf https://raw.githubusercontent.com/Meghthedev/Releases/main/headless.sh | sh
